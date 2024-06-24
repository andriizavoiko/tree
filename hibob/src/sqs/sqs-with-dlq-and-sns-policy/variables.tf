## General
variable "tags" {
  description = "Standard tags"
  type        = map(string)
}

## SQS
variable "sqs_queue_config" {
  description = "SQS queue configuration"
  type = object({
    name                        = string
    fifo_queue                  = optional(bool)
    content_based_deduplication = optional(bool)
    dlq = object({
      name                      = string
      message_retention_seconds = number
    })
    message_retention_seconds  = optional(number)
    visibility_timeout_seconds = optional(number)
    redrive_policy = optional(object({
      deadLetterTargetArn = optional(string)
      maxReceiveCount     = number
    }))
    queue_policy = optional(object({
      source = string
    }))
    tags = optional(map(string))
  })
}
