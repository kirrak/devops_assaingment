provider "aws" {
  region = var.aws_region
}

# Fetch the default VPC
data "aws_vpc" "default" {
  default = true
}

# Fetch the subnets for the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "18.31.0" # Update as needed
  cluster_name    = var.cluster_name
  cluster_version = "1.26"
  vpc_id          = data.aws_vpc.default.id
  subnet_ids      = data.aws_subnets.default.ids
}

# Node group for the EKS cluster
resource "aws_eks_node_group" "example" {
  cluster_name    = module.eks.cluster_name
  node_group_name = "example-node-group"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = data.aws_subnets.default.ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.registry_read_policy,
  ]
}

# IAM role for the node group
resource "aws_iam_role" "node_role" {
  name               = "eks-node-group-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

# IAM policy document for the node role
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# IAM policies for the node group
resource "aws_iam_role_policy_attachment" "worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "registry_read_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_role.name
}

# Ensure there is only one `aws_cloudwatch_log_group.this` resource defined here
resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/eks/default-eks-cluster/cluster"
}

# Comment out any other duplicate definitions of `aws_cloudwatch_log_group.this`
# resource "aws_cloudwatch_log_group" "this" {
#   name = "/aws/eks/default-eks-cluster/cluster"
# }
