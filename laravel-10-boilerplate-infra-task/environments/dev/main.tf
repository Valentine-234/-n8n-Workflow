locals {
  name_prefix = "${var.project}-${var.env}"
  tags = {
    Project     = var.project
    Environment = var.env
    ManagedBy   = "terraform"
  }
}

module "vpc" {
  source               = "../../modules/vpc"
  environment          = var.env
  vpc_cidr             = var.vpc_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  tags                 = local.tags
}


module "eks" {
  source              = "../../modules/eks"
  name_prefix         = local.name_prefix
  cluster_version     = var.cluster_version
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  public_subnet_ids  = module.vpc.public_subnets
  node_instance_types = var.node_instance_types
  node_desired_size   = var.node_desired_size 
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
  tags                = local.tags
}


module "security" {
  source      = "../../modules/security-group"
  vpc_id      = module.vpc.vpc_id
  environment = var.env
  tags        = local.tags
}


module "rds" {
  source = "../../modules/rds"

  project = var.project
  env     = var.env
  tags    = var.tags

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets

  db_name           = local.rds_secret.db_name
  db_username       = local.rds_secret.username
  db_password       = local.rds_secret.password
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
}
