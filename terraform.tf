terraform {
  required_version = "1.9.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.1"
    }
  }
}
# terraform {
#   backend "s3" {
#     region     = "us-east-1"
#     bucket     = "bootcamp-devops-terraform"
#     key        = "bootcamp-devops-teraform.tfstate"
#     # profile = "default"
#   }
# }