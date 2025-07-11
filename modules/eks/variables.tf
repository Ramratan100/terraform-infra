# ========================
# General Configurations
# ========================

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "terraform-eks-demo"
}

variable "region" {
  description = "AWS region for EKS deployment"
  type        = string
  default     = "us-east-1"
}

variable "eks_cluster_version" {
  description = "Kubernetes cluster version in EKS"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# ========================
# Cluster Endpoint Access
# ========================

variable "endpoint_private" {
  description = "Whether the EKS private endpoint is enabled"
  type        = bool
}

variable "endpoint_public" {
  description = "Whether the EKS public endpoint is enabled"
  type        = bool
}

variable "cluster_endpoint_whitelist" {
  description = "Enable security group rule for whitelisted CIDRs on cluster endpoint"
  type        = bool
  default     = false
}

variable "cluster_endpoint_access_cidrs" {
  description = "List of CIDRs to whitelist for cluster endpoint"
  type        = list(string)
  default     = []
}

# ========================
# Logging
# ========================

variable "enabled_cluster_log_types" {
  description = "Control plane logging types to enable"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

# ========================
# VPC & Subnets
# ========================

variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs for the EKS cluster (control plane and shared resources)"
  type        = list(string)
}

# ========================
# Node Groups Configuration
# ========================

variable "create_node_group" {
  description = "Create node groups or not"
  type        = bool
  default     = true
}

variable "eks_node_group_name" {
  description = "Default node group name prefix"
  type        = string
  default     = "eks-node-group"
}

variable "node_groups" {
  description = "Map of node group configurations"
  type = map(object({
    subnets            = list(string)
    instance_type      = list(string)
    disk_size          = number
    desired_capacity   = number
    max_capacity       = number
    min_capacity       = number
    ssh_key            = string
    security_group_ids = list(string)
    tags               = map(string)
    labels             = map(string)
    capacity_type      = string
    ami_type           = string
  }))
}

variable "disk_size" {
  description = "Disk size (in GiB) for EKS worker nodes"
  type        = number
  default     = 20
}

variable "scale_min_size" {
  description = "Minimum number of worker nodes in a node group"
  type        = number
  default     = 2
}

variable "scale_max_size" {
  description = "Maximum number of worker nodes in a node group"
  type        = number
  default     = 5
}

variable "scale_desired_size" {
  description = "Desired number of worker nodes in a node group"
  type        = number
  default     = 3
}

variable "force_update_version" {
  description = "Force update node group version even if existing pods can't be drained"
  type        = bool
  default     = false
}

# ========================
# Add-ons Configurations
# ========================

variable "cluster_autoscaler" {
  description = "Enable cluster autoscaler add-on"
  type        = bool
  default     = true
}

variable "metrics_server" {
  description = "Enable metrics server add-on"
  type        = bool
  default     = true
}

variable "k8s-spot-termination-handler" {
  description = "Enable spot instance termination handler add-on"
  type        = bool
  default     = true
}

# ========================
# Miscellaneous
# ========================

variable "config_output_path" {
  description = "Output path for kubeconfig file"
  type        = string
}

variable "kubeconfig_name" {
  description = "Name for kubeconfig file"
  type        = string
}

variable "slackUrl" {
  description = "Slack webhook URL for notifications"
  type        = string
  default     = ""
}

variable "allow_eks_cidr" {
  description = "CIDRs allowed to access the EKS control plane"
  type        = list(string)
  default     = ["0.0.0.0/32"]
}
