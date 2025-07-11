variable "node_groups" {
  description = "Parameters required for creating multiple EKS managed node groups"
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

variable "cluster_name" {
  description = "Name of the parent EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM Role ARN for the EKS managed node groups"
  type        = string
}

variable "create_node_group" {
  description = "Whether to create the node groups"
  type        = bool
  default     = true
}

variable "force_update_version" {
  description = "Force node group version update when existing pods can’t be drained"
  type        = bool
  default     = false
}

variable "eks_node_group_version" {
  description = "Kubernetes version for EKS managed node groups"
  type        = string
  default     = "1.29"
}

variable "node_role_dependency" {
  description = "List of dependencies for IAM role policy attachments before creating node groups"
  type        = list(any)
  default     = []
}
