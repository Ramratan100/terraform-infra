module "network" {
  source = "../../modules/network"

  cidr_block                           = var.cidr_block
  instance_tenancy                     = var.instance_tenancy
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics
  name                                 = var.name
  tags                                 = var.tags
  vpc_tags                             = var.vpc_tags
  route53_zone                         = var.route53_zone
  azs                                  = var.azs
  public_subnets                       = var.public_subnets
  private_subnets                      = var.private_subnets
  database_subnets                     = var.database_subnets
  additional_public_routes             = var.additional_public_routes
  additional_private_routes            = var.additional_private_routes
  flow_logs_enabled                    = var.flow_logs_enabled
  flow_logs_traffic_type               = var.flow_logs_traffic_type
  flow_logs_file_format                = var.flow_logs_file_format
}

# IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json

  tags = {
    Name = "eks-cluster-role"
  }
}

# Trust Policy for EKS Cluster Role
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

# Attach AmazonEKSClusterPolicy to Role
resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# EKS Cluster Module
module "eks" {
  source            = "../../modules/eks"
  cluster_name      = "ramratan-cluster"
  cluster_role_arn  = aws_iam_role.eks_cluster_role.arn
  subnet_ids        = module.network.public_subnets
  api_subnet_ids    = module.network.private_subnets
  db_subnet_ids     = module.network.database_subnets
}
