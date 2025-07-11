terraform {
  backend "s3" {
    bucket         = "eks-my-tfstate-bucket"
    key            = "eks/network/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
