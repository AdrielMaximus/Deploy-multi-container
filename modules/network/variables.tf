# modules/network/variables.tf

variable "project_name" {
  description = "Nome do projeto ou aplicação (usado em tags e nomes de recursos)"
  type        = string
}

variable "env" {
  description = "Ambiente atual (ex: dev, staging, prod, homolog, test)"
  type        = string
}

variable "region" {
  description = "Região AWS onde os recursos serão criados (ex: sa-east-1, us-east-1)"
  type        = string
}

variable "cidr_block" {
  description = "Bloco CIDR principal da VPC (ex: 10.0.0.0/16)"
  type        = string
}

variable "azs" {
  description = "Lista de Availability Zones a serem usadas (ex: [\"sa-east-1a\", \"sa-east-1b\"])"
  type        = list(string)
}

variable "public_subnets_newbits" {
  description = "Quantos bits serão adicionados ao CIDR da VPC para criar subnets públicas (ex: 8 → /24)"
  type        = number
  default     = 8
}

variable "private_subnets_newbits" {
  description = "Quantos bits serão adicionados ao CIDR da VPC para criar subnets privadas"
  type        = number
  default     = 8
}

variable "enable_nat_gateway" {
  description = "Criar NAT Gateway para permitir saída de internet nas subnets privadas?"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Usar apenas um NAT Gateway (mais econômico) em vez de um por AZ"
  type        = bool
  default     = true
}

variable "common_tags" {
  description = "Mapa de tags adicionais que serão aplicadas a todos os recursos"
  type        = map(string)
  default     = {}
}

# Variáveis opcionais / avançadas (pode adicionar depois se precisar)

variable "enable_dns_hostnames" {
  description = "Habilitar DNS hostnames na VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar suporte a DNS na VPC"
  type        = bool
  default     = true
}