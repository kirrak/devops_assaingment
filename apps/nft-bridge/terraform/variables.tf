variable "aws_region" {
  default = "ap-south-1"
  description = "AWS region to deploy resources."
}

variable "cluster_name" {
  default = "nft-bridge-eks-cluster"
  description = "Name of the EKS cluster."
}

variable "node_group_desired_size" {
  default = 2
  description = "Desired number of worker nodes in the node group."
}

variable "node_group_max_size" {
  default = 3
  description = "Maximum number of worker nodes in the node group."
}

variable "node_group_min_size" {
  default = 1
  description = "Minimum number of worker nodes in the node group."
}
