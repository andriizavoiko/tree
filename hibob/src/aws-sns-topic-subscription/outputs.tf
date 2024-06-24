output "sns_topic_subscription_id" {
  description = "The SNS topic subscription ID"
  value       = aws_sns_topic_subscription.subscription.id
}

output "sns_topic_subscription_arn" {
  description = "The SNS topic subscription ARN"
  value       = aws_sns_topic_subscription.subscription.arn
}