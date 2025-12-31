terraform {
  backend "s3" {
    bucket         = "laravel-10-boilerplate-bucket"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
  }
}