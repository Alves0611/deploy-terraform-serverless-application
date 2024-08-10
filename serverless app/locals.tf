locals {
  account_id              = data.aws_caller_identity.this.account_id
  namespaced_service_name = "${var.service_name}-${var.environment}"
  has_domain_name         = var.domain_name != null


  common_tags = {
    "Module"    = "Static website"
    "ManagedBy" = "Terraform"
  }
}
