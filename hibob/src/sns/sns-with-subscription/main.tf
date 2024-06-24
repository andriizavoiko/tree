terraform {
  required_version = ">= 1.3.0"
}

module "sns_topic" {
  source = "../../aws-sns-topic"

  display_name                     = var.display_name
  sqs_success_feedback_role_arn    = var.sqs_success_feedback_role_arn
  sqs_success_feedback_sample_rate = var.sqs_success_feedback_sample_rate
  sqs_failure_feedback_role_arn    = var.sqs_failure_feedback_role_arn
  name                             = var.sns_topic_config.name
  fifo_topic                       = var.sns_topic_config.fifo_topic
  content_based_deduplication      = var.sns_topic_config.content_based_deduplication
  tags                             = merge(var.tags, var.sns_topic_config.tags)
}

module "sns_topic_subscription" {
  source = "../../aws-sns-topic-subscription"

  for_each = {
    for key, policy in var.sns_topic_config.sub_topic : key => policy
  }

  arn           = module.sns_topic.sns_topic_arn
  endpoint      = each.value.endpoint
  protocol      = var.sns_topic_config.protocol
  filter_policy = each.value.filter_policy
  tags          = merge(var.tags, var.sns_topic_config.tags)
}

module "sns_topic_policy" {
  source = "../../aws-sns-topic-policy"
  count  = var.sns_topic_config.policy != null ? 1 : 0
  arn    = module.sns_topic.sns_topic_arn
  policy = var.sns_topic_config.policy
}
