resource "aws_sqs_queue" "queue" {
  name                        = var.name
  fifo_queue                  = var.fifo_queue
  content_based_deduplication = var.content_based_deduplication
  message_retention_seconds   = var.message_retention_seconds
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  redrive_policy              = var.redrive_policy
  tags                        = var.tags
}