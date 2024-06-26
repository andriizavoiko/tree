output "sqs_queue_id" {
  description = "The SQS queue ID"
  value       = aws_sqs_queue.queue.id
}

output "sqs_queue_name" {
  description = "The SQS queue name"
  value       = aws_sqs_queue.queue.name
}

output "sqs_queue_arn" {
  description = "The SQS queue ARN"
  value       = aws_sqs_queue.queue.arn
}