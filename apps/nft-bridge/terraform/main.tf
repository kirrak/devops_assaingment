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
  version         = "18.31.0" # Adjust the version as needed
  cluster_name    = var.cluster_name
  cluster_version = "1.26"
  vpc_id          = data.aws_vpc.default.id
  subnet_ids      = data.aws_subnets.default.ids # Corrected argument

  # Configure managed node groups
  managed_node_groups = {
    example = {
      name            = "example-node-group"
      instance_types  = ["t3.medium"]
      desired_capacity = 2
      min_capacity     = 1
      max_capacity     = 3
    }
  }
}
