variable "organization" {
  description = "Organization name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}

variable "message_retention_seconds" {
  description = "Message retention seconds"
  type        = number
  default     = 1209600
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout seconds"
  type        = number
  default     = 300
}

variable "max_receive_count" {
  description = "Max receive count for redrive policy"
  type        = number
  default     = 5
}

variable "dlq_message_retention_seconds" {
  description = "Dead Letter Queue message retention seconds"
  type        = number
  default     = 1209600
}
