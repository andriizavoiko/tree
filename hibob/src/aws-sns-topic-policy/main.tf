resource "aws_sns_topic_policy" "default" {
  arn    = var.arn
  policy = var.policy
}