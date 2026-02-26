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


resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  iam_instance_profile        = var.iam_instance_profile
  key_name                    = var.key_name
  user_data                   = var.user_data
  associate_public_ip_address = false



  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-ec2"
  })
}