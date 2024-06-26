## Locals
variable "prefix" {
  description = "Prefix for all resources (organization + environment + region)"
  type        = string
}

variable "tags" {
  description = "Standard tags"
  type        = map(string)
}

## General
variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "Region name"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

## SQS
variable "sqs_names" {
  description = "SQS config names"
  type        = set(string)
}

variable "sqs_cloud_delivery_names" {
  description = "SQS cloud delivery config names"
  type        = set(string)
}

variable "sns_topic_cloud_delivery_arn" {
  description = "SNS cloud delivery ARN"
  type        = string
}