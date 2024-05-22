# resource "aws_s3_bucket_object" "object" {
#   bucket = module.s3.s3_bucket_id
#   key    = "index.html"
#   source = templatefile("${path.module}/templates/viewer-request-default.js"
#   etag   = filemd5(templatefile("${path.module}/templates/index.html")
# }
