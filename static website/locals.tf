locals {
  account_id      = data.aws_caller_identity.current.account_id
  has_domain      = var.domain_name != null
  domain_name     = local.has_domain ? var.domain_name : random_pet.website.id
  regional_domain = "${local.domain_name}.s3.${var.aws_region}.amazonaws.com"

  distribution_id = "E2F16ALWFZXHBJ"

  common_tags = {
    "Module"    = "Static website"
    "ManagedBy" = "Terraform"
  }
}