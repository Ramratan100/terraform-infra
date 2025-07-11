variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_role_arn" {
  description = "ARN of the IAM role for EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where EKS control plane and load balancer will be provisioned"
  type        = list(string)
}

variable "api_subnet_ids" {
  description = "List of private subnet IDs for API node group"
  type        = list(string)
}

variable "db_subnet_ids" {
  description = "List of private subnet IDs for Database node group"
  type        = list(string)
}
