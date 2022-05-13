output "region" {
  value = var.region
}

output "hosted_zone" {
  value = {
    id           = aws_route53_zone.operation.id
    name         = aws_route53_zone.operation.name
    name_servers = aws_route53_zone.operation.name_servers
  }
}

output "sg_ids" {
  value = [
    aws_default_security_group.default.id,
    aws_security_group.allow_http_https.id,
    aws_security_group.allow_ssh.id
  ]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.operation.id
}

output "vpc_id" {
  value = aws_vpc.operation.id
}

output "vpc_cidr_block" {
  value = aws_vpc.operation.cidr_block
}
