terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "../../modules/network"

  project_name = var.project_name
  env          = var.env

  cidr_block = "10.1.0.0/16"
  region     = "us-east-1"

  azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  env          = var.env

  role_name = "${var.project_name}-${var.env}-ec2-role"

  service_principals = ["ec2.amazonaws.com"]
}

module "compute" {
  source = "../../modules/compute"

  project_name = var.project_name
  env          = var.env

  ami_id        = "ami-0c02fb55956c7d316"
  instance_type = "t3.medium"

  vpc_id = module.network.vpc_id

  subnet_id = module.network.public_subnets[0]

  security_group_ids = []
}

module "database" {
  source = "../../modules/database"

  project_name = var.project_name
  env          = var.env

  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnets

  allowed_sg_ids = [module.compute.instance_sg_id]

  engine_version = "15"
  instance_class = "db.t3.medium"

  db_name     = "appdb"
  db_username = "postgres"
  db_password = var.db_password
}