# VPC variables
variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "instance_tenancy" {
  description = "Tenancy for the VPC instances"
  type        = string
  default     = "default"
}

variable "enable_network_address_usage_metrics" {
  description = "Enable network address usage metrics for the VPC"
  type        = bool
  default     = false
}

variable "name" {
  description = "Name prefix for the resources"
  type        = string
}

variable "tags" {
  description = "Global tags for all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "route53_zone" {
  description = "Private Route53 zone name"
  type        = string
  default     = "non-prod.internal"
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "database_subnets" {
  description = "List of CIDR blocks for database subnets"
  type        = list(string)
}

variable "additional_public_routes" {
  description = "Additional routes for public subnets"
  type = map(object({
    destination_cidr_block = string
    gateway_id             = string
  }))
  default = {}
}

variable "additional_private_routes" {
  description = "Additional routes for private subnets"
  type = list(object({
    destination_cidr_block = string
    gateway_id             = string
  }))
  default = []
}

variable "flow_logs_enabled" {
  description = "Enable VPC Flow Logs"
  type        = bool
  default     = false
}

variable "flow_logs_traffic_type" {
  description = "Type of traffic for VPC Flow Logs"
  type        = string
  default     = "ALL"
}

variable "flow_logs_file_format" {
  description = "File format for Flow Logs"
  type        = string
  default     = "parquet"
}

# EKS cluster variables
variable "cluster_name" {
  description = "Name for the EKS cluster"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "eks_cluster_version" {
  description = "Kubernetes cluster version for EKS"
  type        = string
}

variable "config_output_path" {
  description = "Path where kubeconfig will be generated"
  type        = string
}

variable "kubeconfig_name" {
  description = "Name for the generated kubeconfig"
  type        = string
}

variable "ssh_key_name" {
  description = "SSH key pair name for EC2 instances in EKS node groups"
  type        = string
}

variable "endpoint_private" {
  description = "Enable private API endpoint"
  type        = bool
  default     = true
}

variable "endpoint_public" {
  description = "Enable public API endpoint"
  type        = bool
  default     = true
}

variable "create_node_group" {
  description = "Whether to create node groups"
  type        = bool
  default     = true
}

variable "force_update_version" {
  description = "Force EKS version update"
  type        = bool
  default     = false
}

variable "cluster_endpoint_whitelist" {
  description = "Enable cluster endpoint CIDR whitelist"
  type        = bool
  default     = false
}

variable "cluster_endpoint_access_cidrs" {
  description = "List of CIDRs to whitelist for cluster endpoint"
  type        = list(string)
  default     = []
}

# API node group config
variable "api_node_instance_type" {
  type = list(string)
}

variable "api_node_disk_size" {
  type = number
}

variable "api_node_desired_capacity" {
  type = number
}

variable "api_node_max_capacity" {
  type = number
}

variable "api_node_min_capacity" {
  type = number
}

variable "api_node_capacity_type" {
  type = string
}

variable "api_node_ami_type" {
  type = string
}

# DB node group config
variable "db_node_instance_type" {
  type = list(string)
}

variable "db_node_disk_size" {
  type = number
}

variable "db_node_desired_capacity" {
  type = number
}

variable "db_node_max_capacity" {
  type = number
}

variable "db_node_min_capacity" {
  type = number
}

variable "db_node_capacity_type" {
  type = string
}

variable "db_node_ami_type" {
  type = string
}
