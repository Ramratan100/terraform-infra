# General VPC config
cidr_block                           = "10.0.0.0/16"
instance_tenancy                     = "default"
enable_network_address_usage_metrics = false
name                                 = "dev-infra"

# Global tags
tags = {
  "Environment" = "dev"
  "Owner"       = "Ramratan"
}

vpc_tags = {
  "Team" = "DevOps"
}

# Route53 Zone
route53_zone = "dev.internal"

# Availability Zones
azs = ["us-east-2a", "us-east-2b"]

# Subnet CIDRs
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.11.0/24", "10.0.21.0/24"]
database_subnets = ["10.0.12.0/24", "10.0.22.0/24"]

# Additional public routes (if any)
additional_public_routes = {}

# Additional private routes (if any)
additional_private_routes = []

# VPC Flow Logs config
flow_logs_enabled       = false
flow_logs_traffic_type  = "ALL"
flow_logs_file_format   = "parquet"
