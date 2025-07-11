resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [aws_iam_role.eks_cluster_role]
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster_name}-eks-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
}

data "aws_iam_policy_document" "eks_assume_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_eks_node_group" "api_nodes" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "api-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.api_subnet_ids
  scaling_config {
    desired_size = 1
    max_size     = 4
    min_size     = 1
  }
}

resource "aws_eks_node_group" "db_nodes" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "db-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.db_subnet_ids
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
}

resource "aws_iam_role" "eks_node_role" {
  name = "${var.cluster_name}-eks-node-role"
  assume_role_policy = data.aws_iam_policy_document.eks_node_assume_role_policy.json
}

data "aws_iam_policy_document" "eks_node_assume_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}
