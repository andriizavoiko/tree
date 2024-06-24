output "sns_topic_id" {
  description = "The SNS topic ID"
  value       = aws_sns_topic.topic.id
}

output "sns_topic_name" {
  description = "The SNS topic name"
  value       = aws_sns_topic.topic.name
}

output "sns_topic_arn" {
  description = "The SNS topic ARN"
  value       = aws_sns_topic.topic.arn
}