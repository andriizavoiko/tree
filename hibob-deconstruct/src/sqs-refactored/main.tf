resource "aws_sqs_queue" "q" {
  for_each                          = { for queue in var.sqs_queue : queue.name => queue }
  name                              = lookup(each.value, "name", null)
  name_prefix                       = lookup(each.value, "name_prefix", null)
  visibility_timeout_seconds        = lookup(each.value, "visibility_timeout_seconds", null)
  message_retention_seconds         = lookup(each.value, "message_retention_seconds", null)
  max_message_size                  = lookup(each.value, "max_message_size", null)
  delay_seconds                     = lookup(each.value, "delay_seconds", null)
  receive_wait_time_seconds         = lookup(each.value, "receive_wait_time_seconds", null)
  policy                            = lookup(each.value, "policy", null)
  redrive_policy                    = lookup(each.value, "redrive_policy", null)
  redrive_allow_policy              = lookup(each.value, "redrive_allow_policy", null)
  fifo_queue                        = lookup(each.value, "fifo_queue", null)
  fifo_throughput_limit             = lookup(each.value, "fifo_throughput_limit", null)
  deduplication_scope               = lookup(each.value, "deduplication_scope", null)
  content_based_deduplication       = lookup(each.value, "content_based_deduplication", null)
  kms_master_key_id                 = lookup(each.value, "kms_master_key_id", var.kms_master_key_id)
  kms_data_key_reuse_period_seconds = lookup(each.value, "kms_data_key_reuse_period_seconds", null)
  tags                              = lookup(each.value, "tags", var.tags)
}

locals {
  cloudwatch_metric_alarm = flatten([
    for queue in var.sqs_queue : [
      for metric_alarm in lookup(queue, "cloudwatch_metric_alarm", []) : {
        queue_name = queue.name
        alarm      = metric_alarm
      } if can(lookup(queue, "cloudwatch_metric_alarm"))
    ]
  ])
}

resource "aws_cloudwatch_metric_alarm" "a" {
  for_each            = { for metric_alarm in local.cloudwatch_metric_alarm : metric_alarm.queue_name => metric_alarm.alarm }
  alarm_name          = lookup(each.value, "alarm_name")
  comparison_operator = lookup(each.value, "comparison_operator")
  evaluation_periods  = lookup(each.value, "evaluation_periods")
  metric_name         = lookup(each.value, "metric_name", null)
  namespace           = "AWS/SQS"
  period              = lookup(each.value, "period", null)
  statistic           = lookup(each.value, "statistic", null)
  threshold           = lookup(each.value, "threshold", null)
  alarm_description   = lookup(each.value, "alarm_description", null)
  actions_enabled     = lookup(each.value, "actions_enabled", true)
  alarm_actions       = lookup(each.value, "alarm_actions", null)
  ok_actions          = lookup(each.value, "ok_actions", null)
  dimensions          = { QueueName = each.key }
  treat_missing_data  = lookup(each.value, "treat_missing_data", "missing")
  tags                = lookup(each.value, "tags", var.tags)
  depends_on          = [aws_sqs_queue.q]
}
