module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = "ml_prediction_housing_prices"
  cluster_version = "1.22"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = data.aws_vpc.default.id
  subnet_ids = ["subnet-0228a03aa5a07b864", "subnet-0941693649050b098", "subnet-00f0bfc2413a4a18b"]

  manage_aws_auth_configmap = true

  aws_auth_accounts = ["095394318170"]

  eks_managed_node_groups = {
    blue = {
      min_size     = 1
      max_size     = 1
      desired_size = 1

      instance_types = ["t2.micro"]
      capacity_type  = "ON_DEMAND"
    }
    green = {
      min_size     = 0
      max_size     = 1
      desired_size = 0

      instance_types = ["t2.micro"]
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}