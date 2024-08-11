data "aws_iam_policy_document" "this" {
  dynamic "statement" {
    for_each = var.permissions

    content {
      sid       = statement.value["sid"]
      effect    = statement.value["effect"]
      resources = statement.value["resources"]
      actions   = statement.value["actions"]
    }
  }
}
