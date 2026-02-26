variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "role_name" {
    type = string
}

variable "service_principals" {
    type = list(string)
}

variable "create_instance_profile"{
    type    = bool
    default = true
}

variable "managed_policy_arns" {
    type    = list(string)
    default = []
}