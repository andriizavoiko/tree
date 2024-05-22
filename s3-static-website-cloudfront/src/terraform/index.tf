resource "aws_s3_object" "index" {
  bucket       = module.s3.s3_bucket_id
  key          = "index.html"
  source       = "${path.module}/templates/index.html"
  etag         = filemd5("${path.module}/templates/index.html")
  content_type = "text/html"
  depends_on   = [module.s3]
}
