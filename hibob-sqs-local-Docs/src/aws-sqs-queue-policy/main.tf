resource "aws_sqs_queue_policy" "policy" {
  queue_url = var.queue_url
  policy    = var.queue_policy
}