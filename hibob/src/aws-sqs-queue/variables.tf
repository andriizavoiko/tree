## General
variable "tags" {
  description = "Standard tags"
  type        = map(string)
}

## SQS
variable "name" {
  description = "SQS queue name"
  type        = string
}

variable "message_retention_seconds" {
  description = "SQS queue message retention time in seconds"
  type        = number
  default     = null
}

variable "visibility_timeout_seconds" {
  description = "SQS queue visibility timeout in seconds"
  type        = number
  default     = null
}

variable "redrive_policy" {
  description = "SQS queue redrive policy"
  type        = string
  default     = null
}

variable "fifo_queue" {
  description = "SQS queue FIFO option"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "SQS queue content based deduplication for FIFO queues"
  type        = bool
  default     = null
}