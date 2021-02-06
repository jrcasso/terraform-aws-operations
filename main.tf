terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

# VPC and networking resources

resource "aws_vpc" "operation" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    ops = var.name
  }
}

resource "aws_internet_gateway" "operation" {
  vpc_id = aws_vpc.operation.id

  tags = {
    ops = var.name
  }
}

resource "aws_default_route_table" "operation" {
  default_route_table_id = aws_vpc.operation.default_route_table_id

  tags = {
    ops = var.name
  }
}

resource "aws_route" "open_route" {
  route_table_id         = aws_default_route_table.operation.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.operation.id
  depends_on             = [aws_default_route_table.operation]
}


# Route 53 resources

resource "aws_route53_zone" "operation" {
  name = "${var.name}.${var.parent_zone.name}"

  tags = {
    ops = var.name
  }
}

resource "aws_route53_record" "domain_ns_for_operation" {
  allow_overwrite = true
  name            = "${var.name}.${var.parent_zone.name}"
  ttl             = 300
  type            = "NS"
  zone_id         = var.parent_zone.id

  records = [
    aws_route53_zone.operation.name_servers[0],
    aws_route53_zone.operation.name_servers[1],
    aws_route53_zone.operation.name_servers[2],
    aws_route53_zone.operation.name_servers[3],
  ]
}

# Security Group resources

resource "aws_default_security_group" "default" {
  // Default behavior is to accept all
  vpc_id = aws_vpc.operation.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_http_https" {
  name        = "allow_https"
  description = "Allow HTTPS inbound traffic"
  vpc_id      = aws_vpc.operation.id

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    ops = var.name
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.operation.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # [aws_vpc.primary.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    ops = var.name
  }
}

