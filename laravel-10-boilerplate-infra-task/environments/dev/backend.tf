terraform {
  backend "s3" {
    bucket         = "laravel-10-boilerplate-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-west-2"
  }
}