output "node_group_arns" {
  description = "ARNs of the EKS managed node groups"
  value = {
    for k, ng in aws_eks_node_group.node_groups :
    k => ng.arn
  }
}

output "node_group_resources" {
  description = "Resources created for the EKS managed node groups"
  value = {
    for k, ng in aws_eks_node_group.node_groups :
    k => ng.resources
  }
}

output "node_group_names" {
  description = "Names of all EKS node groups"
  value = [
    for ng in aws_eks_node_group.node_groups :
    ng.node_group_name
  ]
}

output "node_group_ids" {
  description = "IDs of all EKS managed node groups"
  value = [
    for ng in aws_eks_node_group.node_groups :
    ng.id
  ]
}

# Optional — only include if you're using remote_access in node groups
output "node_group_security_group_ids" {
  description = "Remote access security group IDs created for the node groups"
  value = {
    for k, ng in aws_eks_node_group.node_groups :
    k => try(ng.resources.remote_access_security_group_id, null)
  }
}
