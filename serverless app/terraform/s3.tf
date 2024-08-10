resource "aws_s3_bucket" "lambda_artefacts" {
  bucket = "${local.account_id}-lambda-artefacts"
}
