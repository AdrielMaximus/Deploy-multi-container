# environments/dev/main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # ou var.region, se preferir
}

module "network" {
    source = "../../modules/network"
    region = "us-east-1"

    project_name       = "teste"
    env                = "dev"
    cidr_block         = "10.99.0.0/16"
    azs                = ["us-east-1a", "us-east-1b"]

    enable_nat_gateway = true
    single_nat_gateway = true

    common_tags = {
        Ambiente   = "dev"
        Projeto    = "aprendizado"
        Gerenciado = "Terraform"
    }
}

# Outputs para você ver o resultado
output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnets" {
  value = module.network.public_subnets
}

output "private_subnets" {
  value = module.network.private_subnets
}