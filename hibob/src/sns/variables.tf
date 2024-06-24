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

## SNS
variable "function_filter_policies" {
  description = "Function filter policies"
  type        = map(string)
}

variable "sns_names" {
  description = "SNS config names"
  type        = set(string)
}