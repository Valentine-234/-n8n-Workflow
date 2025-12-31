terraform {
  backend "s3" {
    bucket         = "laravel-10-boilerplate-bucket"
    key            = "staging/terraform.tfstate"
    region         = "us-east-1"
  }
}
