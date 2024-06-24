resource "aws_sns_topic" "sns_topic" {
  for_each = var.sns_names

  name = "${var.prefix}-${each.key}"

  tags = var.tags
}

resource "aws_sns_topic_subscription" "cloud_delivery_sqs_subscription" {
  for_each = var.function_filter_policies

  topic_arn     = aws_sns_topic.sns_topic["cloud-delivery"].arn
  protocol      = "sqs"
  filter_policy = var.function_filter_policies[each.key]
  endpoint      = "arn:aws:sqs:${var.region}:${var.account_id}:${var.prefix}-${each.key}"
}