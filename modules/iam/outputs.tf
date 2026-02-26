output "role_name" {
  value = aws_iam_role.test_role.name
}

output "role_arn" {
  value = aws_iam_role.test_role.arn
}

output "instance_profile_name" {
  value = var.create_instance_profile ? aws_iam_instance_profile.this[0].name : null
}