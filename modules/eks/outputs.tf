output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.this.name
}

output "api_node_group_name" {
  description = "The name of the API node group"
  value       = aws_eks_node_group.api_nodes.node_group_name
}

output "db_node_group_name" {
  description = "The name of the Database node group"
  value       = aws_eks_node_group.db_nodes.node_group_name
}
