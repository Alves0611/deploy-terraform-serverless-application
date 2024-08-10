locals {
  has_domain  = var.domain_name != null
  domain_name = local.has_domain ? var.domain_name : random_pet.website.id
}
