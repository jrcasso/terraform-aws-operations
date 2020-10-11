variable "region" {
  type        = string
  default = "us-east-1"
  description = "AWS Region"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC subnet CIDR for the operation"
}

variable "parent_zone" {
  type        = object({
    name = string
    id   = string
  })
  description = "VPC subnet CIDR for the operation"
}

variable "profile" {
  type        = string
  default     = "personal"
  description = "AWS profile"
}

variable "name" {
  type        = string
  description = "Operation name; prototypical scopes include dev, stage, and production 'environments'."
}
