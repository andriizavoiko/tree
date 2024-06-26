variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "sqs_queue" {
  description = "List of SQS queue configurations."
  type = list(object({
    name                              = string
    name_prefix                       = optional(string, null)
    visibility_timeout_seconds        = optional(number, null)
    message_retention_seconds         = optional(number, null)
    max_message_size                  = optional(number, null)
    delay_seconds                     = optional(number, null)
    receive_wait_time_seconds         = optional(number, null)
    policy                            = optional(string, null)
    redrive_policy                    = optional(string, null)
    redrive_allow_policy              = optional(string, null)
    fifo_queue                        = optional(bool, null)
    fifo_throughput_limit             = optional(string, null)
    deduplication_scope               = optional(string, null)
    content_based_deduplication       = optional(bool, null)
    kms_master_key_id                 = optional(string, null)
    kms_data_key_reuse_period_seconds = optional(number, null)
    tags                              = optional(map(string), null)
    cloudwatch_metric_alarm = optional(list(object({
      alarm_name          = string
      comparison_operator = string
      evaluation_periods  = number
      metric_name         = optional(string, null)
      period              = optional(number, null)
      statistic           = optional(string, null)
      threshold           = optional(number, null)
      alarm_description   = optional(string, null)
      actions_enabled     = optional(bool, true)
      alarm_actions       = optional(list(string), null)
      ok_actions          = optional(list(string), null)
      treat_missing_data  = optional(string, "missing")
      tags                = optional(map(string), null)
    })), [])
  }))
  default = [] # Empty list by default, users can override this as needed
}
