resource "aws_vpc" "operation" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    env = var.name
  }
}

resource "aws_internet_gateway" "operation" {
  vpc_id = aws_vpc.operation.id

  tags = {
    env = var.name
  }
}

resource "aws_default_route_table" "operation" {
  default_route_table_id = aws_vpc.operation.default_route_table_id

  tags = {
    env = var.name
  }
}

resource "aws_route" "open_route" {
  route_table_id         = aws_default_route_table.operation.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.operation.id
  depends_on             = [aws_default_route_table.operation]
}
