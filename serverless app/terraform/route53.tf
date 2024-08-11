data "aws_route53_zone" "apex_domain" {
  count = local.create_resource_based_on_domain_name

  name         = var.domain_name
  private_zone = false
}

resource "aws_acm_certificate" "api" {
  count = local.create_resource_based_on_domain_name

  domain_name       = "api.${var.domain_name}"
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "api" {
  count = local.create_resource_based_on_domain_name

  certificate_arn         = aws_acm_certificate.api[0].arn
  validation_record_fqdns = [for record in aws_route53_record.api_validation : record.fqdn]
}