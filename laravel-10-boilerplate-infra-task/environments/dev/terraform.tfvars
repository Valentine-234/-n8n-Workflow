aws_region = "eu-west-1"
env        = "dev"
project    = "laravel-10-boilerplate-task"

vpc_cidr = "10.10.0.0/16"
azs      = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
private_subnet_cidrs = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]

cluster_version = "1.30"
node_instance_types = ["t3.medium"]
node_desired_size = 2
node_min_size = 2
node_max_size = 4
