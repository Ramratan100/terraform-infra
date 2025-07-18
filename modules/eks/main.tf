# ===============================
# EKS Cluster Resource
# ===============================

resource "aws_eks_cluster" "eks_cluster" {
  name                      = var.cluster_name
  enabled_cluster_log_types = var.enabled_cluster_log_types
  role_arn                  = aws_iam_role.cluster_role.arn
  version                   = var.eks_cluster_version

  vpc_config {
    subnet_ids              = var.subnets
    endpoint_private_access = var.endpoint_private
    endpoint_public_access  = var.endpoint_public
  }

  tags = merge(
    {
      Name        = "${var.cluster_name}-cluster"
      Provisioner = "Terraform"
    },
    var.tags
  )

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSServicePolicy
  ]
}

# ===============================
# EKS Node Groups Module
# ===============================

module "node_groups" {
  source            = "./modules/eks_node_group"
  create_node_group = var.create_node_group
  cluster_name      = aws_eks_cluster.eks_cluster.id
  node_role_arn     = aws_iam_role.node_group_role.arn
  node_groups       = var.node_groups
}

# ===============================
# EKS Cluster IAM Role
# ===============================

resource "aws_iam_role" "cluster_role" {
  name               = "${var.cluster_name}-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.cluster_assume_role_policy.json

  tags = merge(
    {
      Name        = "${var.cluster_name}-cluster_iam_role"
      Provisioner = "Terraform"
    },
    var.tags
  )
}

data "aws_iam_policy_document" "cluster_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.cluster_role.name
}

# ===============================
# Node Group IAM Role
# ===============================

resource "aws_iam_role" "node_group_role" {
  name               = "${var.cluster_name}-node-group-role"
  assume_role_policy = data.aws_iam_policy_document.node_group_assume_role_policy.json

  tags = merge(
    {
      Name        = "${var.cluster_name}-node_group_iam_role"
      Provisioner = "Terraform"
    },
    var.tags
  )
}

data "aws_iam_policy_document" "node_group_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2FullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.node_group_role.name
}

# ===============================
# Kubernetes Tags on Subnets
# ===============================

resource "aws_ec2_tag" "eks_subnet_tag" {
  count       = length(var.subnets)
  resource_id = var.subnets[count.index]
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "shared"
}

# ===============================
# EKS Cluster Security Group Rule (Optional Whitelist)
# ===============================

resource "aws_security_group_rule" "cluster_private_access" {
  count       = var.cluster_endpoint_whitelist ? 1 : 0
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = var.cluster_endpoint_access_cidrs

  security_group_id = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
}
