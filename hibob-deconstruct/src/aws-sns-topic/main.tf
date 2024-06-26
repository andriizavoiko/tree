resource "aws_sns_topic" "topic" {
  name                             = var.name
  fifo_topic                       = var.fifo_topic
  content_based_deduplication      = var.content_based_deduplication
  tags                             = var.tags
  sqs_success_feedback_role_arn    = var.sqs_success_feedback_role_arn
  sqs_success_feedback_sample_rate = var.sqs_success_feedback_sample_rate
  sqs_failure_feedback_role_arn    = var.sqs_failure_feedback_role_arn
  display_name                     = var.display_name
}
