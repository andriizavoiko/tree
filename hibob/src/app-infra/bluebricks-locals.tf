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

  sns_topic_config = [
    {
      name      = "${local.prefix}-user-notifications"
      protocol  = "sqs"
      sub_topic = {}
    },
    {
      name     = "${local.prefix}-backend-notifications"
      protocol = "sqs"
      sub_topic = {
        recruiting = {
          endpoint = "${local.sqs_arn_prefix}Recruiting-bob-notifications-${title(var.environment)}"
        }
      }
    },
    {
      name      = "${local.prefix}-external-files-tagged"
      protocol  = "sqs"
      sub_topic = {}
      policy    = <<-EOT
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "s3.amazonaws.com"
            },
            "Action": "SNS:Publish",
            "Resource": "arn:aws:sns:${var.region}:${var.account_id}:${local.prefix}-external-files-tagged"
        }
    ]
}
      EOT
    }
  ]

  sqs_queue_config_local = [
    {
      name = "Compensation-${title(format("%s-local", var.environment))}"
      dlq = {
        name                      = "Compensation-${title(format("%s-local", var.environment))}-Dead-Letter"
        message_retention_seconds = var.dlq_message_retention_seconds
      }
      message_retention_seconds  = var.message_retention_seconds
      visibility_timeout_seconds = var.visibility_timeout_seconds

      redrive_policy = {
        maxReceiveCount = var.max_receive_count
      }
     
    },
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

  ## SQS
  sqs_queue_config = [
    {
      name = "Recruiting-bob-notifications-${title(var.environment)}"
      dlq = {
        name                      = "Recruiting-bob-notifications-${title(var.environment)}-Dead-Letter"
        message_retention_seconds = var.dlq_message_retention_seconds
      }
      message_retention_seconds  = var.message_retention_seconds
      visibility_timeout_seconds = var.visibility_timeout_seconds

      redrive_policy = {
        maxReceiveCount = var.max_receive_count
      }
     
    },
    {
      name = "Compensation-${title(var.environment)}"
      dlq = {
        name                      = "Compensation-${title(var.environment)}-Dead-Letter"
        message_retention_seconds = var.dlq_message_retention_seconds
      }
      message_retention_seconds  = var.message_retention_seconds
      visibility_timeout_seconds = var.visibility_timeout_seconds

      redrive_policy = {
        maxReceiveCount = var.max_receive_count
      }
     
    },
    {
      name = "Docs-${title(var.environment)}"
      dlq = {
        name                      = "Docs-${title(var.environment)}-Dead-Letter"
        message_retention_seconds = var.dlq_message_retention_seconds
      }
      message_retention_seconds  = var.message_retention_seconds
      visibility_timeout_seconds = var.visibility_timeout_seconds

      redrive_policy = {
        maxReceiveCount = var.max_receive_count
      }
     
    }
  ]

  sns_topic_config_local = [
    {
      name      = "${local.prefix_local}-user-notifications"
      protocol  = "sqs"
      sub_topic = {}
    },
    {
      name      = "${local.prefix_local}-backend-notifications"
      protocol  = "sqs"
      sub_topic = {}
    }
  ]
}
