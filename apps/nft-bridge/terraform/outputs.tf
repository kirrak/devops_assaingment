output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
  description = "Name of the EKS cluster."
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
  description = "Endpoint of the EKS cluster."
}

output "eks_cluster_certificate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
  description = "Certificate Authority data for the EKS cluster."
}
