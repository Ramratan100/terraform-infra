# ===============================
# EKS Cluster Outputs
# ===============================

output "eks_cluster_id" {
  description = "The EKS cluster ID"
  value       = aws_eks_cluster.eks_cluster.id
}

output "eks_cluster_arn" {
  description = "The EKS cluster ARN"
  value       = aws_eks_cluster.eks_cluster.arn
}

output "eks_cluster_endpoint" {
  description = "API server endpoint URL for the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

# ===============================
# EKS Cluster IAM Role Outputs
# ===============================

output "cluster_iam_role_arn" {
  description = "IAM Role ARN for the EKS control plane"
  value       = aws_iam_role.cluster_role.arn
}

# ===============================
# Worker Node IAM Role Outputs
# ===============================

output "node_group_iam_role_arn" {
  description = "IAM Role ARN for the EKS worker node group"
  value       = aws_iam_role.node_group_role.arn
}

# ===============================
# Node Group Outputs from submodule
# ===============================

output "node_group_arns" {
  description = "Map of ARNs for created EKS node groups"
  value       = module.node_groups.node_group_arns
}

output "node_group_resources" {
  description = "Map of created EKS node group resources"
  value       = module.node_groups.node_group_resources
}

output "node_group_names" {
  description = "List of names of created EKS node groups"
  value       = module.node_groups.node_group_names
}

output "node_group_ids" {
  description = "List of IDs of created EKS managed node groups"
  value       = module.node_groups.node_group_ids
}

output "node_group_security_group_ids" {
  description = "Map of remote access security group IDs for node groups"
  value       = module.node_groups.node_group_security_group_ids
}
