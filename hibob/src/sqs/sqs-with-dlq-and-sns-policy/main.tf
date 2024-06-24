terraform {
  required_version = ">= 1.3.0"
}

module "sqs_dlq" {
  source = "../../aws-sqs-queue"

  name                        = var.sqs_queue_config.dlq.name
  fifo_queue                  = var.sqs_queue_config.fifo_queue
  content_based_deduplication = var.sqs_queue_config.content_based_deduplication
  message_retention_seconds   = var.sqs_queue_config.dlq.message_retention_seconds
  tags                        = merge(var.tags, var.sqs_queue_config.tags)
}

module "sqs_queue" {
  source = "../../aws-sqs-queue"

  name                        = var.sqs_queue_config.name
  fifo_queue                  = var.sqs_queue_config.fifo_queue
  content_based_deduplication = var.sqs_queue_config.content_based_deduplication
  message_retention_seconds   = var.sqs_queue_config.message_retention_seconds
  visibility_timeout_seconds  = var.sqs_queue_config.visibility_timeout_seconds
  redrive_policy = jsonencode(merge(var.sqs_queue_config.redrive_policy, {
    deadLetterTargetArn = module.sqs_dlq.sqs_queue_arn
  }))

  tags = merge(var.tags, var.sqs_queue_config.tags)
}

module "sqs_policy" {
  source = "../../aws-sqs-queue-policy"

  count = var.sqs_queue_config.queue_policy != null ? 1 : 0

  queue_url    = module.sqs_queue.sqs_queue_id
  queue_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${module.sqs_queue.sqs_queue_arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${var.sqs_queue_config.queue_policy.source}"
        }
      }
    }
  ]
}
POLICY
}
