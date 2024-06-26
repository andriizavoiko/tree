resource "aws_sns_topic" "t" {
  for_each                                 = { for topic in var.sns_topic : topic.name => topic }
  name                                     = lookup(each.value, "name", null)
  name_prefix                              = lookup(each.value, "name_prefix", null)
  display_name                             = lookup(each.value, "display_name", null)
  policy                                   = lookup(each.value, "policy", null)
  delivery_policy                          = lookup(each.value, "delivery_policy", null)
  application_success_feedback_role_arn    = lookup(each.value, "application_success_feedback_role_arn", null)
  application_success_feedback_sample_rate = lookup(each.value, "application_success_feedback_sample_rate", null)
  application_failure_feedback_role_arn    = lookup(each.value, "application_failure_feedback_role_arn", null)
  http_success_feedback_role_arn           = lookup(each.value, "http_success_feedback_role_arn", null)
  http_success_feedback_sample_rate        = lookup(each.value, "http_success_feedback_sample_rate", null)
  http_failure_feedback_role_arn           = lookup(each.value, "http_failure_feedback_role_arn", null)
  kms_master_key_id                        = lookup(each.value, "kms_master_key_id", var.kms_master_key_id)
  lambda_success_feedback_role_arn         = lookup(each.value, "lambda_success_feedback_role_arn", null)
  lambda_success_feedback_sample_rate      = lookup(each.value, "lambda_success_feedback_sample_rate", null)
  lambda_failure_feedback_role_arn         = lookup(each.value, "lambda_failure_feedback_role_arn", null)
  sqs_success_feedback_role_arn            = lookup(each.value, "sqs_success_feedback_role_arn", null)
  sqs_success_feedback_sample_rate         = lookup(each.value, "sqs_success_feedback_sample_rate", null)
  sqs_failure_feedback_role_arn            = lookup(each.value, "sqs_failure_feedback_role_arn", null)
  tags                                     = lookup(each.value, "tags", var.tags)
}

locals {
  sns_topic_subscription = flatten([
    for topic in var.sns_topic : [
      for subscription in lookup(topic, "subscription", []) : {
        name     = topic.name
        protocol = subscription.protocol
        endpoint = subscription.endpoint
      } if lookup(topic, "subscription", null) != null
    ]
  ])
}

resource "aws_sns_topic_subscription" "s" {
  for_each  = { for subscription in local.sns_topic_subscription : format("%s/%s", subscription.name, subscription.endpoint) => subscription }
  topic_arn = aws_sns_topic.t[lookup(each.value, "name")].arn
  protocol  = lookup(each.value, "protocol")
  endpoint  = lookup(each.value, "endpoint")
}
