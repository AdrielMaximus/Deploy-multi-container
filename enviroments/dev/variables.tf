variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "role_name"{
    type      = string
}