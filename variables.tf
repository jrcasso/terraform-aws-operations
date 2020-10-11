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

variable "name" {
  type        = string
  description = "Infrastructural environment: dev/stage/production"
}
