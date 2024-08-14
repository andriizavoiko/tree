module "s3" {
  source         = "terraform-aws-modules/s3-bucket/aws"
  version        = "~> 4.1"
  create_bucket  = var.create_bucket
  bucket         = var.bucket_name
  cors_rule      = var.cors_rule
  lifecycle_rule = var.lifecycle_rule
  versioning     = var.versioning
  logging        = var.logging
}
