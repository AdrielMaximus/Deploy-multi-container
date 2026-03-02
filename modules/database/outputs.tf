output "endpoint" {
  value = aws_db_instance.default.endpoint
}

output "db_sg_id" {
  value = aws_security_group.db.id
}