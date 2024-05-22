locals {
  acm_domains  = [for domain in var.domains : domain if domain.include_in_acm]
  domain_parts = length(local.acm_domains) > 0 ? split(".", local.acm_domains[0].domain) : []
}

module "acm" {
  source = "terraform-aws-modules/acm/aws"
  providers = {
    aws = aws.use1
  }
  version                   = "~> 4.3.0"
  create_certificate        = var.create_certificate
  create_route53_records    = false
  wait_for_validation       = false
  key_algorithm             = var.acm_key_algorithm
  domain_name               = length(local.acm_domains) > 0 ? local.acm_domains[0].domain : ""
  subject_alternative_names = length(local.acm_domains) > 0 ? concat([format("*.%s", join(".", slice(local.domain_parts, 0, length(local.domain_parts))))]) : []
}
