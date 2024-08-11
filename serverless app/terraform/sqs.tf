resource "aws_sqs_queue" "this" {
  name                       = local.namespaced_service_name
  visibility_timeout_seconds = 30   # >= timeout of sqs lambda
  message_retention_seconds  = 3600 # after 1 hour the message is sent to dlq

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.this_dlq.arn
    maxReceiveCount     = 4 # number of retries before sending to dlq
  })
}