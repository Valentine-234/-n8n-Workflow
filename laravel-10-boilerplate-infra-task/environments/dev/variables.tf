variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "env" {
  type        = string
  description = "Environment name dev staging prod"
}

variable "tags" {
  type     = map(string)
  default  = {}
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "azs" {
  type        = list(string)
  description = "Availability zones"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDRs"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDRs"
}

variable "project" {
  type = string
}

variable "cluster_version" {
  type        = string
  description = "EKS version"
  default     = "1.30"
}

variable "node_instance_types" {
  type        = list(string)
  description = "Node instance types"
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  type        = number
  default     = 2
}

variable "node_min_size" {
  type        = number
  default     = 2
}

variable "node_max_size" {
  type        = number
  default     = 4
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "instance_class" {
  type    = string
  default = "db.t4g.micro"
}
 