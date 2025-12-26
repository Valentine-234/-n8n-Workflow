# Core
aws_region = "us-west-2"
env        = "dev"
project    = "laravel-10-boilerplate-task"

# Networking
vpc_cidr = "10.10.0.0/16"

azs = [
  "us-west-2a",
  "us-west-2b",
  "us-west-2c"
]

public_subnet_cidrs = [
  "10.10.1.0/24",
  "10.10.2.0/24",
  "10.10.3.0/24"
]

private_subnet_cidrs = [
  "10.10.11.0/24",
  "10.10.12.0/24",
  "10.10.13.0/24"
]

# EKS
cluster_version     = "1.30"
node_instance_types = ["t3.medium"]

node_desired_size = 2
node_min_size     = 2
node_max_size     = 4

# RDS
db_name     = "boilerplate-db"
db_username = "boilerplate-db"
db_password = "task12345"

instance_class    = "db.t3.micro"
allocated_storage = 20

# Common tags
tags = {
  Project     = "laravel-10-boilerplate-task"
  Environment = "dev"
  ManagedBy   = "terraform"
}
