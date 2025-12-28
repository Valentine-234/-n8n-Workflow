
variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where security groups will be created"
  type        = string
}

variable "backend_ingress_cidr" {
  description = "Allowed CIDR range for backend internal access"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "frontend_ingress_cidr" {
  description = "Allowed CIDR range for frontend public access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "backend_port" {
  description = "Port exposed by the backend service"
  type        = number
  default     = 8080
}

variable "frontend_port" {
  description = "Port exposed by the frontend service"
  type        = number
  default     = 80
}

variable "tags" {
  description = "Additional tags applied to all security group resources"
  type        = map(string)
  default     = {}
}
