
terraform {
  backend "s3" {
    bucket         = "laravel-10-boilerplate-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
  }
}


provider "aws" {
  region = var.aws_region
}


