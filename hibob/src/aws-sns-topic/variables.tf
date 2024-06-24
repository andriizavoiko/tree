## General
variable "tags" {
  description = "Standard tags"
  type        = map(string)
}

## SNS
variable "name" {
  description = "SNS topic name"
  type        = string
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

variable "fifo_topic" {
  description = "SNS Topic FIFO option"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "SNS Topic content based deduplication for FIFO topics"
  type        = bool
  default     = null
}