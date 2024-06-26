# ## SNS
output "sns_topic_arn" {
  description = "SNS topics ARN"
  value       = { for key, topic in module.sns : key => topic.sns_topic_arn }
}

output "sns_topic_arn_local" {
  description = "SNS topics ARN for local env"
  value       = { for key, topic in module.sns_local : key => topic.sns_topic_arn }
}

## SQS
output "sqs_queue_arn" {
  description = "SQS queue ARN"
  value = {
    for key, queue in module.sqs : key => queue.sqs_queue_arn
  }
}

output "sqs_queue_arn_local" {
  description = "SQS queue ARN for Local env"
  value = {
    for key, queue in module.sqs_local : key => queue.sqs_queue_arn
  }
}
