output "sns_topic_arn" {
  description = "SNS topics ARN"
  value = {
    for key, topic in aws_sns_topic.sns_topic : key => topic.arn
  }
}