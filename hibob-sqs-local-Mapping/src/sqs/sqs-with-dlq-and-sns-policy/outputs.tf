output "sqs_queue_dlq_arn" {
  description = "The SQS DLQ queue ARN"
  value       = module.sqs_dlq.sqs_queue_arn
}

output "sqs_queue_dlq_name" {
  description = "The SQS DLQ queue name"
  value       = module.sqs_dlq.sqs_queue_name
}

output "sqs_queue_arn" {
  description = "The SQS queue ARN"
  value       = module.sqs_queue.sqs_queue_arn
}

output "sqs_queue_name" {
  description = "The SQS queue name"
  value       = module.sqs_queue.sqs_queue_name
}
