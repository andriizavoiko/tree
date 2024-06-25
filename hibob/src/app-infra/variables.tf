## General
variable "tags" {
  description = "Tags"
  type        = map
}

variable "organization" {
  description = "Organization name"
  type        = string
}

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

## Replication
variable "is_replicated" {
  description = "Regional replication"
  type        = bool
}

variable "regions" {
  description = "Map of regions"
  type        = map(string)
}

variable "azs" {
  description = "Map of azs"
  type        = list(string)
}

## S3
variable "s3_replication_role" {
  description = "Role to replicate S3 buckets"
  type        = string
}

## Akeyless
variable "access_id" {
  type = string
}
