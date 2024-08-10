resource "aws_acm_certificate" "this" {
  count = local.has_domain ? 1 : 0

  provider = aws.us_east_1

  domain_name               = local.domain_name
  validation_method         = "DNS"
  subject_alternative_names = ["*.${local.domain_name}"]
}