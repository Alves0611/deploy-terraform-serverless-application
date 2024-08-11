variable "permissions" {
  type = list(object({
    sid       = string
    effect    = optional(string, "Allow")
    resources = list(string)
    actions   = list(string)
  }))
  description = "The permissions to set for the given policy document"
}
