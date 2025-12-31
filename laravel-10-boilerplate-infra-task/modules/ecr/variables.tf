variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "IMMUTABLE or MUTABLE"
  type        = string
  default     = "IMMUTABLE"
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}

variable "enable_lifecycle_policy" {
  description = "Enable ECR lifecycle policy"
  type        = bool
  default     = true
}

variable "untagged_image_retention_days" {
  description = "Days to retain untagged images"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags applied to the repository"
  type        = map(string)
  default     = {}
}
