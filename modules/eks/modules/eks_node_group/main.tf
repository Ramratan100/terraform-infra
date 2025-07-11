resource "aws_eks_node_group" "node_groups" {
  for_each     = var.create_node_group ? var.node_groups : {}
  cluster_name = var.cluster_name

  node_group_name        = each.key
  node_role_arn          = var.node_role_arn
  subnet_ids             = each.value.subnets
  instance_types         = each.value.instance_type
  disk_size              = each.value.disk_size
  labels                 = each.value.labels
  capacity_type          = each.value.capacity_type
  ami_type               = each.value.ami_type
  force_update_version   = var.force_update_version
  version                = var.eks_node_group_version

  scaling_config {
    desired_size = each.value.desired_capacity
    max_size     = each.value.max_capacity
    min_size     = each.value.min_capacity
  }

  update_config {
    max_unavailable = 1
  }

  remote_access {
    ec2_ssh_key               = each.value.ssh_key
    source_security_group_ids = each.value.security_group_ids
  }

  tags = merge(
    {
      "Name"        = format("%s-%s", var.cluster_name, each.key)
      "Provisioner" = "Terraform"
      "Cluster"     = var.cluster_name
    },
    each.value.tags
  )

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
    ignore_changes        = [
      scaling_config[0].desired_size
    ]
  }

  depends_on = [var.node_role_dependency]
}
