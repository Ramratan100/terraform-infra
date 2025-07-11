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
public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets  = ["10.0.11.0/24", "10.0.21.0/24"]
database_subnets = ["10.0.12.0/24", "10.0.22.0/24"]

# Additional public routes (if any)
additional_public_routes = {}
additional_private_routes = []

# VPC Flow Logs config
flow_logs_enabled      = false
flow_logs_traffic_type = "ALL"
flow_logs_file_format  = "parquet"

# EKS Cluster Config
cluster_name          = "ramratan-cluster"
region                = "us-east-2"
eks_cluster_version   = "1.30"

config_output_path    = "./kubeconfigs/"
kubeconfig_name       = "ramratan-cluster"

ssh_key_name          = "ramratan-keypair"

# API Node Group Config
api_node_instance_type    = ["t3.medium"]
api_node_disk_size        = 20
api_node_desired_capacity = 2
api_node_max_capacity     = 3
api_node_min_capacity     = 1
api_node_capacity_type    = "ON_DEMAND"
api_node_ami_type         = "AL2_x86_64"

# DB Node Group Config
db_node_instance_type    = ["t3.medium"]
db_node_disk_size        = 20
db_node_desired_capacity = 1
db_node_max_capacity     = 2
db_node_min_capacity     = 1
db_node_capacity_type    = "ON_DEMAND"
db_node_ami_type         = "AL2_x86_64"
