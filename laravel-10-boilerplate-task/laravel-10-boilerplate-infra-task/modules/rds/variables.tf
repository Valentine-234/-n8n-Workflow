variable "project" {
  type = string
}

variable "tags" { 
  type = map(string) 
}

variable "env" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
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