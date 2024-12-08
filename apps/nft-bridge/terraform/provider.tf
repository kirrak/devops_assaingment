# configure aws provider
provider "aws" {
  region = var.region
}

# configure backend
terraform {
  backend "s3" {
    bucket         = "terraformstates3bucket"
    key            = "aws-eks-terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform_state"
  }
}