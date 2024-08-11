output "cognito_pool_id" {
  value = aws_cognito_user_pool.this.id
}

output "cognito_client_id" {
  value = aws_cognito_user_pool_client.this.id
}

output "cognito_url" {
  value = "https://${aws_cognito_user_pool_domain.this.domain}.auth.${var.aws_region}.amazoncognito.com"
}

output "lambda_s3_invoke_url" {
  value = module.lambda_s3.invoke_arn
}

output "lambda_dynamo_invoke_url" {
  value = module.lambda_dynamodb.invoke_arn
}

output "lambda_sqs_invoke_url" {
  value = module.lambda_sqs.invoke_arn
}