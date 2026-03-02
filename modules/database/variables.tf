variable "project_name" { type = string }
variable "env" { type = string }

variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }

variable "db_name" { type = string }
variable "db_username" { type = string }
variable "db_password" { type = string }

variable "instance_class" { type = string }
variable "engine_version" { type = string }

variable "allowed_sg_ids" {
  type = list(string)
}
variable "common_tags" {
  type    = map(string)
  default = {}
}