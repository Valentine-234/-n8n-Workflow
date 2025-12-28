
terraform {
  backend "s3" {
    bucket         = "laravel-10-boilerplate-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-west-2"
  }
}


provider "aws" {
  region = var.aws_region
}


