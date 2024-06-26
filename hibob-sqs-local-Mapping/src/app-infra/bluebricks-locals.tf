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
      name = "Mapping-${title(format("%s-local", var.environment))}"

      dlq = {
        name                      = "Mapping-${title(format("%s-local", var.environment))}-Dead-Letter"
        message_retention_seconds = 1209600
      }
      message_retention_seconds  = 1209600
      visibility_timeout_seconds = 300

      redrive_policy = {
        maxReceiveCount = 5
      }
    },
  ]
}


