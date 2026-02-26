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

# Trust Policy (quem pode assumir a role) - usando data source (melhor prática)
data "aws_iam_policy_document" "assume_role" {
  statement {
    sid    = "AllowEC2AssumeRole"
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.service_principals
    }
  }
}

# Cria a IAM Role
resource "aws_iam_role" "this" {
  name               = "${local.name_prefix}-${var.role_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = local.common_tags
}

# Anexa políticas gerenciadas (AWS Managed Policies)
resource "aws_iam_role_policy_attachment" "managed" {
  for_each = toset(var.managed_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}

# (Opcional) Cria Instance Profile para a EC2 usar a role
resource "aws_iam_instance_profile" "this" {
  count = var.create_instance_profile ? 1 : 0

  name = "${aws_iam_role.this.name}-profile"
  role = aws_iam_role.this.name

  tags = local.common_tags
}