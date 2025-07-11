# VPC ID
output "vpc_id" {
  value       = module.network.vpc_id
  description = "The ID of the created VPC"
}

# VPC CIDR Block
output "vpc_cidr_block" {
  value       = module.network.vpc_cidr_block
}

# Public Subnets IDs
output "public_subnets" {
  value       = module.network.public_subnets
}

# Private Subnets IDs
output "private_subnets" {
  value       = module.network.private_subnets
}

# Database Subnets IDs
output "database_subnets" {
  value       = module.network.database_subnets
}

# NAT Gateway IPs
output "nat_gateway_ips" {
  value = module.network.nat_gateway_ips
}

# Internet Gateway ID
output "igw_id" {
  value = module.network.igw_id
}

# Route53 Zone ID
output "route53_zone_id" {
  value = module.network.route53_zone_id
}
