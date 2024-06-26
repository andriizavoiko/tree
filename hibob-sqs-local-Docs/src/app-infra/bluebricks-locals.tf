locals {
  ## Resource prefix from organization + environment + region
  prefix      = "${var.organization}-${var.environment}-${var.region}"
  desc_prefix = title("${var.organization} ${var.environment} ${var.region}")

  ## Local environment changes
  prefix_local      = "${var.organization}-${var.environment}-local-${var.region}"
  desc_prefix_local = title("${var.organization} ${var.environment} Local ${var.region}")

  sqs_arn_prefix = "arn:aws:sqs:${var.region}:${var.account_id}:"

  ## Environment name set by the Terraform workspace
  standard_tags = {
    environment = var.environment
    created_By  = "Terraform"
  }

  standard_tags_local = merge(
    local.standard_tags,
    var.tags
  )

  sqs_queue_config_local = [
    {
      name = "Docs-${title(format("%s-local", var.environment))}"
      dlq = {
        name                      = "Docs-${title(format("%s-local", var.environment))}-Dead-Letter"
        message_retention_seconds = var.dlq_message_retention_seconds
      }
      message_retention_seconds  = var.message_retention_seconds
      visibility_timeout_seconds = var.visibility_timeout_seconds

      redrive_policy = {
        maxReceiveCount = var.max_receive_count
      }
     
    }
  ]
}