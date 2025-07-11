# ===============================
# VPC Outputs
# ===============================

output "vpc_id" {
  value       = module.network.vpc_id
  description = "The ID of the created VPC"
}

output "vpc_cidr_block" {
  value       = module.network.vpc_cidr_block
  description = "The CIDR block of the created VPC"
}

output "public_subnets" {
  value       = module.network.public_subnets
  description = "List of public subnet IDs"
}

output "private_subnets" {
  value       = module.network.private_subnets
  description = "List of private subnet IDs"
}

output "database_subnets" {
  value       = module.network.database_subnets
  description = "List of database subnet IDs"
}

output "nat_gateway_ips" {
  value       = module.network.nat_gateway_ips
  description = "Public IP addresses of the NAT gateways"
}

output "igw_id" {
  value       = module.network.igw_id
  description = "Internet Gateway ID"
}

output "route53_zone_id" {
  value       = module.network.route53_zone_id
  description = "Route53 private zone ID"
}

# ===============================
# EKS Outputs
# ===============================

output "eks_cluster_endpoint" {
  value       = module.eks.eks_cluster_endpoint
  description = "The endpoint URL for the EKS cluster"
}

output "eks_cluster_arn" {
  value       = module.eks.eks_cluster_arn
  description = "The ARN of the EKS cluster"
}

output "eks_cluster_id" {
  value       = module.eks.eks_cluster_id
  description = "The ID of the EKS cluster"
}

output "eks_cluster_certificate_authority_data" {
  value       = module.eks.eks_cluster_certificate_authority_data
  description = "Certificate authority data for the cluster kubeconfig"
}

output "node_group_arns" {
  value       = module.eks.node_group_arns
  description = "ARNs of all created EKS node groups"
}

output "node_group_resources" {
  value       = module.eks.node_group_resources
  description = "Resource info of all EKS node groups"
}
