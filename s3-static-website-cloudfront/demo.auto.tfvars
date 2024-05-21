Owner         = "hibob"
TenantID      = "8989"
environment   = "Demo"
region        = "eu-central-1"
force_destroy = "true"
bucket_name   = "bob-test.demo.bricks-dev.com"
domains = {
  demo = {
    dns_zone_id         = "Z07456365WP3KMQLDUTZ"
    domain              = "bob-test.demo.bricks-dev.com"
    create_alias_record = true
    include_in_acm      = true
    create_acm_record   = true
  }
}
