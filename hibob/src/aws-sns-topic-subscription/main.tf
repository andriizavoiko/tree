resource "aws_sns_topic_subscription" "subscription" {
  topic_arn     = var.arn
  protocol      = var.protocol
  filter_policy = var.filter_policy
  endpoint      = var.endpoint
}