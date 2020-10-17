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
