variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "iam_instance_profile" {
  type    = string
  default = null
}

variable "key_name" {
  type    = string
  default = null
}

variable "user_data" {
  type    = string
  default = null
}

variable "common_tags" {
  type    = map(string)
  default = {}
}
variable "vpc_id" {
  description = "VPC ID where the EC2 will be created"
  type        = string
}