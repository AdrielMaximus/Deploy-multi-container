variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "ssh_cidr_blocks" {
  description = "CIDRs allowed for SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}