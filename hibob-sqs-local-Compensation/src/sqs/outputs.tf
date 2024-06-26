output "sqs_queue_services_dlq_arn" {
  description = "SQS queue services DLQ ARN"
  value = {
    for key, queue in aws_sqs_queue.services_dlq : key => queue.arn
  }
}

output "sqs_queue_services_arn" {
  description = "SQS queue services ARN"
  value = {
    for key, queue in aws_sqs_queue.services : key => queue.arn
  }
}

output "sqs_queue_cloud_delivery_dlq_arn" {
  description = "SQS queue cloud delivery DLQ ARN"
  value = {
    for key, queue in aws_sqs_queue.cloud_delivery_dlq : key => queue.arn
  }
}

output "sqs_queue_cloud_delivery_arn" {
  description = "SQS queue cloud delivery ARN"
  value = {
    for key, queue in aws_sqs_queue.cloud_delivery : key => queue.arn
  }
}

output "sqs_queue_cloud_delivery_policy_id" {
  description = "SQS queue cloud delivery policy ID"
  value = {
    for key, policy in aws_sqs_queue_policy.cloud_delivery : key => policy.id
  }
}