# AWS Provider Configuration
provider "aws" {
  region = "ap-south-1"  # Change to your desired AWS region
}

# IAM Role Creation
resource "aws_iam_role" "node_role" {
  name               = "my-unique-eks-node-group-role"  # Change this to a unique name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Role Policy
resource "aws_iam_role_policy" "node_role_policy" {
  name = "my-node-role-policy"
  role = aws_iam_role.node_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "eks:DescribeCluster",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents",
          "logs:CreateLogGroup",
          "logs:CreateLogStream"
        ]
        Resource = "*"
      }
    ]
  })
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/eks/my-unique-cluster-log-group"  # Change this to a unique name
  retention_in_days = 30
}

# IAM User (GitHubActionsuser) Creation
resource "aws_iam_user" "user" {
  name = "GitHubActionsuser"  # Replace with your actual IAM user name
}

# Attach Policy to IAM User
resource "aws_iam_policy_attachment" "attach_policy_to_user" {
  name       = "attach-node-role-policy-to-user"
  users      = ["GitHubActionsuser"]  # Replace with your actual IAM user name
  policy_arn = aws_iam_role_policy.node_role_policy.arn  # Attach the policy created above
}

# Attach IAM Role to User (via AssumeRole permission)
resource "aws_iam_role_policy_attachment" "attach_role_to_user" {
  policy_arn = aws_iam_role.node_role.arn
  role       = aws_iam_role.node_role.name
  users      = ["GitHubActionsuser"]  # Attach the role to the IAM user
}
