variable "permissions" {
  type = list(object({
    sid       = string
    effect    = optional(string, "Allow")
    resources = list(string)
    actions   = list(string)
  }))
  description = "The permissions to set for the given policy document"
}

variable "create_log_perms_for_lambda" {
  type        = bool
  description = "Whether to create the Lambda permissions for Cloudwatch"
  default     = false
}
