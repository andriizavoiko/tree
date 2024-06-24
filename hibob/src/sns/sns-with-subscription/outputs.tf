output "sns_topic_id" {
  description = "The SNS topic ID"
  value       = module.sns_topic.sns_topic_id
}

output "sns_topic_name" {
  description = "The SNS topic name"
  value       = module.sns_topic.sns_topic_name
}

output "sns_topic_arn" {
  description = "The SNS topic ARN"
  value       = module.sns_topic.sns_topic_arn
}