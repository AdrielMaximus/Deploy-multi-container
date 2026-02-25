terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

locals {
  name_prefix = "${var.project_name}-${var.env}"

  common_tags = merge(
    var.common_tags,
    {
      Environment = var.env
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  )
  az_map = {
    for index, az in var.azs :
    az => index
  }

  vpc_name     = "${local.name_prefix}-vpc"
  igw_name     = "${local.name_prefix}-igw"
  nat_name     = "${local.name_prefix}-nat"
  public_rt    = "${local.name_prefix}-public-rt"
  private_rt   = "${local.name_prefix}-private-rt"
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = local.vpc_name
  })
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = local.igw_name
  })
}

# Subnets Públicas 
resource "aws_subnet" "public" {
  for_each = local.az_map
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, each.value)
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-public-${each.key}"
    Type = "public"
  })
}

# Subnets Privadas 
resource "aws_subnet" "private" {
  for_each = local.az_map

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, each.value + length(var.azs))
  availability_zone = each.key

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-private-${each.key}"
    Type = "private"
  })
}

# Route Table Pública + rota para IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(local.common_tags, {
    Name = local.public_rt
  })
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# NAT Gateway 
resource "aws_eip" "nat" {
  count  = var.enable_nat_gateway && var.single_nat_gateway ? 1 : 0
  domain = "vpc"

  tags = local.common_tags
}

resource "aws_nat_gateway" "main" {
  count         = var.enable_nat_gateway && var.single_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = values(aws_subnet.public)[0].id  

  tags = merge(local.common_tags, {
    Name = local.nat_name
  })

  depends_on = [aws_internet_gateway.main]
}

# Route Table Privada + rota para NAT
resource "aws_route_table" "private" {
  count = var.enable_nat_gateway ? 1 : 0
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[0].id
  }

  tags = merge(local.common_tags, {
    Name = local.private_rt
  })
}

resource "aws_route_table_association" "private" {
  for_each = var.enable_nat_gateway ? aws_subnet.private : {}

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[0].id
}