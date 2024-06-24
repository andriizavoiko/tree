## General
variable "tags" {
  description = "Standard tags"
  type        = map(string)
}

## SNS
variable "sns_topic_config" {
  description = "SNS topic config"
  type = object({
    name                        = string
    fifo_topic                  = optional(bool)
    content_based_deduplication = optional(bool)
    protocol                    = string
    policy                      = optional(string)
    sub_topic = optional(map(object({
      endpoint      = string
      filter_policy = optional(string)
    })))
    tags = optional(map(string))
  })
}
variable "sqs_failure_feedback_role_arn" {
  description = "Standard tags"
  type        = string
}

variable "sqs_success_feedback_role_arn" {
  description = "Standard tags"
  type        = string
}

variable "sqs_success_feedback_sample_rate" {
  description = "Standard tags"
  type        = number
}

variable "display_name" {
  description = "Standard tags"
  type        = string
}
