resource "aws_sqs_queue" "services_dlq" {
  for_each                  = var.sqs_names
  name                      = "${each.key}-${title(var.environment)}-Dead-Letter"
  message_retention_seconds = 1209600

  tags = var.tags
}

resource "aws_sqs_queue" "services" {
  for_each                  = var.sqs_names
  name                      = "${each.key}-${title(var.environment)}"
  message_retention_seconds = 1209600

  visibility_timeout_seconds = 300

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.services_dlq[each.key].arn
    maxReceiveCount     = 5
  })

  tags = var.tags
}

resource "aws_sqs_queue" "cloud_delivery_dlq" {
  for_each                  = var.sqs_cloud_delivery_names
  name                      = "${var.prefix}-${each.key}-dlq"
  message_retention_seconds = 1209600

  tags = var.tags
}

resource "aws_sqs_queue" "cloud_delivery" {
  for_each                  = var.sqs_cloud_delivery_names
  name                      = "${var.prefix}-${each.key}"
  message_retention_seconds = 1209600

  visibility_timeout_seconds = 300

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.cloud_delivery_dlq[each.key].arn
    maxReceiveCount     = 5
  })

  tags = var.tags
}

resource "aws_sqs_queue_policy" "cloud_delivery" {
  for_each  = aws_sqs_queue.cloud_delivery
  queue_url = each.value.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${each.value.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${var.sns_topic_cloud_delivery_arn}"
        }
      }
    }
  ]
}
POLICY
}