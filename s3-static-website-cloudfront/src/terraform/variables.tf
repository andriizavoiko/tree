# Bluebricks
variable "Owner" {
  description = "The owner of the resources."
  type        = string
}

variable "TenantID" {
  description = "The tenant ID associated with the resources."
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)."
  type        = string
}

variable "region" {
  type = string
}

variable "create_bucket" {
  description = "Whether to create S3 bucket, default to true"
  type        = bool
  default     = true
}

variable "force_destroy" {}

variable "target_origin_id" {
  type    = string
  default = "origin_access_control"
}

variable "bucket_name" {
  description = "bucket name"
  type        = string
  default     = ""
}

variable "acl" {
  description = "Private or Public ACL"
  type        = string
  default     = null
}

variable "attach_policy" {
  description = "Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy)"
  type        = bool
  default     = true
}

variable "policy" {
  description = "A valid bucket policy JSON document (Optional)"
  type        = string
  default     = ""
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "server_side_encryption_configuration" {
  description = "Map containing server-side encryption configuration."
  type        = any
  default     = {}
}

variable "lifecycle_rule" {
  description = "List of maps containing configuration of object lifecycle management."
  type        = any
  default     = []
}

variable "cors_rule" {
  description = "List of maps containing rules for Cross-Origin Resource Sharing for S3 bucket."
  type        = any
  default = {
    cors_rule = {
      allowed_headers = ["*"]
      allowed_methods = ["PUT", "POST", "GET", "DELETE"]
      allowed_origins = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  }
}

variable "versioning" {
  description = "Map containing versioning configuration."
  type        = map(string)
  default = {
    enabled = true
  }
}

variable "logging" {
  description = "Map containing access bucket logging configuration."
  type        = map(string)
  default     = {}
}

variable "website" {
  description = "Map containing static web-site hosting or redirect configuration."
  type        = any # map(string)
  default = {
    index_document = "index.html"
    error_document = "error.html"
  }
}

variable "wait_for_deployment" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = false
}

variable "create_distribution" {
  description = "Whether to create distribution"
  type        = bool
  default     = true
}

variable "create_origin_access_identity" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = false
}

variable "ordered_cache_behavior" {
  description = "An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0."
  type        = any
  default     = []
}

variable "price_class" {
  description = "The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  type        = string
  default     = "PriceClass_All"
}

variable "http_version" {
  description = "The maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3, and http3. The default is http3."
  type        = string
  default     = "http3"
}

variable "cloudfront_logging_config" {
  description = "The logging configuration that controls how logs are written to your distribution"
  type        = map(string)
  default     = {}
}

variable "origin_access_identities" {
  description = "Map of CloudFront origin access identities (value as a comment)"
  type        = map(string)
  default     = {}
}

variable "create_origin_access_control" {
  description = "Controls if CloudFront origin access control should be created"
  type        = bool
  default     = true
}

variable "origin_access_control" {
  description = "Map of CloudFront origin access control"
  type = map(object({
    description      = string
    origin_type      = string
    signing_behavior = string
    signing_protocol = string
  }))
  default = {
    s3 = {
      description      = "Cloudfront origin access control",
      origin_type      = "s3",
      signing_behavior = "always",
      signing_protocol = "sigv4"
    }
  }
}

variable "s3_origin_access_control_key" {
  description = "Key in `origin_access_control` to use for S3 origin access control"
  type        = string
  default     = "s3"
}

variable "origin" {
  description = "One or more origins for this distribution (multiples allowed)."
  type        = any
  default     = {}
}

variable "origin_path" {
  description = "Origin path to a specific directory in s3"
  type        = string
  default     = ""
}

variable "additional_aliases" {
  description = "cloudfront additional aliases"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to be associated with the cloudfront distribution"
  type        = map(string)
  default     = {}
}

variable "default_cache_behavior" {
  description = "The default cache behavior for this distribution"
  type        = any
  default     = {}
}

variable "default_root_object" {
  description = "Default root object"
  type        = string
  default     = "index.html"
}

variable "custom_error_response" {
  description = "Custom error response settings, if any"
  type        = list(any)
  default = [
    {
      error_code         = 404
      response_code      = 404
      response_page_path = "/errors/404.html"
    },
    {
      error_code         = 403
      response_code      = 403
      response_page_path = "/errors/403.html"
    },
  ]
}

variable "geo_restriction" {
  description = "Geo-restriction settings, if any"
  type        = any
  default     = {}
}

variable "certificate_settings" {
  description = "CloudFront certificate settings"
  type        = any
  default = {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}

variable "create_certificate" {
  description = "Create ACM certificate"
  type        = bool
  default     = true
}

variable "existing_acm_certificate_arn" {
  description = "Existing ACM certificate"
  type        = string
  default     = ""
}

variable "domains" {
  description = "Domains or FQDNs to update DNS records and create ACM certificates"
  type = map(object({ # Key is arbitrary and not used
    dns_zone_id         = optional(string)
    domain              = string
    create_alias_record = optional(bool, true)
    include_in_acm      = optional(bool, false)
    create_acm_record   = optional(bool, true)
  }))
  default = {}
}

variable "acm_key_algorithm" {
  description = "ACM certificate algorithm"
  type        = string
  default     = "EC_prime256v1"
}

variable "web_acl_id" {
  description = "A unique identifier that specifies the AWS WAF web ACL, if any, to associate with this distribution. To specify a web ACL created using the latest version of AWS WAF (WAFv2), use the ACL ARN, for example aws_wafv2_web_acl.example.arn. To specify a web ACL created using AWS WAF Classic, use the ACL ID, for example aws_waf_web_acl.example.id. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned."
  type        = string
  default     = ""
}

variable "create_associate_function" {
  description = "If the CloudFront function should be associated with the default cache behavior."
  type        = bool
  default     = false
}

variable "default_index_function_name" {
  description = "Name of the CloudFront Function to create for index page redirection"
  type        = string
  default     = "default_viewer_request"
}

variable "override_default_index_function_code" {
  description = "Function code to override default index viewer request function. Useful when you need to add more functianlity in the viewer request function."
  type        = string
  default     = ""
}

variable "prefix" {
  description = "If required to add prefix to the domain in cloudfront alternate domain names"
  type        = string
  default     = ""
}
