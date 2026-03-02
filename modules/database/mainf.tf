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
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-${var.env}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = local.common_tags
}

resource "aws_security_group" "db" {
  name = "${var.project_name}-${var.env}-db-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = var.allowed_sg_ids
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "default" {
  identifier = "${var.project_name}-${var.env}-db"

  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage = 20

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]

  publicly_accessible = false
  skip_final_snapshot = false
  storage_encrypted = true
  backup_retention_period = 7
  deletion_protection = true
  final_snapshot_identifier = "${local.name_prefix}-final-snapshot"

  multi_az = false

  tags = local.common_tags
}