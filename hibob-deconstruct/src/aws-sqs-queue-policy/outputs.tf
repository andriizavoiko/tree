output "sqs_queue_policy_id" {
  description = "The SQS queue policy ID"
  value       = aws_sqs_queue_policy.policy.id
}