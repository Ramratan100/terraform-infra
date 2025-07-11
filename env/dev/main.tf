# VPC + Networking Module
module "network" {
  source = "../../modules/network"

  cidr_block                           = var.cidr_block
  instance_tenancy                     = var.instance_tenancy
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics
  name                                 = var.name
  tags                                 = var.tags
  vpc_tags                             = var.vpc_tags
  route53_zone                         = var.route53_zone
  azs                                  = var.azs

  public_subnets                       = var.public_subnets
  private_subnets                      = var.private_subnets
  database_subnets                     = var.database_subnets

  additional_public_routes             = var.additional_public_routes
  additional_private_routes            = var.additional_private_routes

  flow_logs_enabled                    = var.flow_logs_enabled
  flow_logs_traffic_type               = var.flow_logs_traffic_type
  flow_logs_file_format                = var.flow_logs_file_format
}

# EKS Cluster + Node Groups Module
module "eks" {
  source               = "../../modules/eks"

  cluster_name         = var.cluster_name
  eks_cluster_version  = var.eks_cluster_version
  region               = var.region
  vpc_id               = module.network.vpc_id
  subnets              = concat(module.network.private_subnets, module.network.database_subnets)

  endpoint_private     = var.endpoint_private
  endpoint_public      = var.endpoint_public

  config_output_path   = var.config_output_path
  kubeconfig_name      = var.kubeconfig_name

  create_node_group          = var.create_node_group
  force_update_version       = var.force_update_version
  cluster_endpoint_whitelist = var.cluster_endpoint_whitelist
  cluster_endpoint_access_cidrs = var.cluster_endpoint_access_cidrs

  tags = var.tags

  node_groups = {
    api_node_group = {
      subnets               = module.network.private_subnets
      instance_type         = var.api_node_instance_type
      disk_size             = var.api_node_disk_size
      desired_capacity      = var.api_node_desired_capacity
      max_capacity          = var.api_node_max_capacity
      min_capacity          = var.api_node_min_capacity
      ssh_key               = var.ssh_key_name
      security_group_ids    = []
      tags                  = { "role" = "api" }
      labels                = { "nodegroup" = "api" }
      capacity_type         = var.api_node_capacity_type
      ami_type              = var.api_node_ami_type
    }

    db_node_group = {
      subnets               = module.network.database_subnets
      instance_type         = var.db_node_instance_type
      disk_size             = var.db_node_disk_size
      desired_capacity      = var.db_node_desired_capacity
      max_capacity          = var.db_node_max_capacity
      min_capacity          = var.db_node_min_capacity
      ssh_key               = var.ssh_key_name
      security_group_ids    = []
      tags                  = { "role" = "database" }
      labels                = { "nodegroup" = "database" }
      capacity_type         = var.db_node_capacity_type
      ami_type              = var.db_node_ami_type
    }
  }
}
