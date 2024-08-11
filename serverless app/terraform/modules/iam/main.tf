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

  dynamic "statement" {
    for_each = var.create_log_perms_for_lambda ? [
      {
        sid       = "AllowCreatingLogGroups"
        resources = ["arn:aws:logs:*:*:*"]
        actions   = ["logs:CreateLogGroup"]
      },
      {
        sid       = "AllowWritingLogs"
        resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]
        actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
      }
    ] : []

    content {
      sid       = statement.value["sid"]
      effect    = "Allow"
      resources = statement.value["resources"]
      actions   = statement.value["actions"]
    }
  }
}