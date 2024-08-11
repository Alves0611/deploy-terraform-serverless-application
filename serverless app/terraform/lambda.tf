# --------------- LAMBDA CODE --------------------
resource "terraform_data" "build" {
  triggers_replace = {
    code_hash = local.code_hash
  }

  provisioner "local-exec" {
    command     = "npm run build"
    working_dir = "${path.module}/../"
  }
}

resource "random_uuid" "build_id" {
  keepers = {
    code_hash = local.code_hash
  }
}

data "archive_file" "codebase" {
  depends_on = [terraform_data.build]

  type        = "zip"
  source_dir  = "${path.module}/../dist"
  output_path = "files/${random_uuid.build_id.result}.zip"
}

module "lambda_s3" {
  source = "./modules/lambda"

  name            = "${local.namespaced_service_name}-s3"
  description     = "Reads file from S3 and publishes messages into a SNS topic"
  iam_role_arn    = module.iam_role_s3_lambda.iam_role_arn
  handler         = "${local.lambdas_path}/s3.handler"
  timeout_in_secs = 20
  memory_in_mb    = 256
  code_hash       = data.archive_file.codebase.output_base64sha256

  s3_config = {
    bucket = aws_s3_bucket.lambda_artefacts.bucket
    key    = aws_s3_object.lambda_artefact.key
  }

  env_vars = {
    TOPIC_ARN = aws_sns_topic.this.arn
    DEBUG     = var.environment == "dev"
  }
}