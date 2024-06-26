output "topic_arn" {
  value = { for topic in aws_sns_topic.t : topic.name => topic.arn }
}
