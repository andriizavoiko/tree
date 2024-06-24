output "queue_arn" {
  value = { for queue in aws_sqs_queue.q : queue.name => queue.arn }
}

output "queue_id" {
  value = { for queue in aws_sqs_queue.q : queue.name => queue.id }
}
