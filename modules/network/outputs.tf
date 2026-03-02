# modules/network/outputs.tf

output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "Bloco CIDR da VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnets" {
  description = "Lista de IDs das subnets públicas"
  value       = [for s in aws_subnet.public : s.id]
}

output "public_subnet_cidrs" {
  description = "Lista de CIDRs das subnets públicas"
  value       = [for s in aws_subnet.public : s.cidr_block]
}

output "private_subnets" {
  description = "Lista de IDs das subnets privadas"
  value       = [for s in aws_subnet.private : s.id]
}

output "private_subnet_cidrs" {
  description = "Lista de CIDRs das subnets privadas"
  value       = [for s in aws_subnet.private : s.cidr_block]
}

output "internet_gateway_id" {
  description = "ID do Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_id" {
  description = "ID do NAT Gateway (se criado)"
  value       = try(aws_nat_gateway.main[0].id, null)
}

output "nat_gateway_public_ip" {
  description = "IP público associado ao NAT Gateway (se criado)"
  value       = try(aws_eip.nat[0].public_ip, null)
}

output "public_route_table_id" {
  description = "ID da route table pública"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID da route table privada (se NAT estiver habilitado)"
  value       = try(aws_route_table.private[0].id, null)
}

