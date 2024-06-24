## General
organization = "bluebricks-dev"
environment  = "dev"
account_id   = "891377293969"
region       = "eu-central-1"

## Replication
is_replicated = false

regions = {
  cloudfront = "us-east-1"
  replica    = "eu-central-1"
}

s3_replication_role = "arn:aws:iam::242867168342:role/cross-account-bucket-replication-policy-new"

azs = ["eu-west-1a", "eu-west-1b"]

## Akeyless
access_id = "p-1mjte23qsetc"
