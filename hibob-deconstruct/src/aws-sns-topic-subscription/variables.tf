## General
variable "tags" {
  description = "Standard tags"
  type        = map(string)
}

## SNS
variable "arn" {
  description = "SNS topic ARN"
  type        = string
}

variable "protocol" {
  description = "SNS topic protocol"
  type        = string
}

variable "filter_policy" {
  description = "SNS topic filter policy"
  type        = string
}

variable "endpoint" {
  description = "SNS topic endpoint"
  type        = string
}