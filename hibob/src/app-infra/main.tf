# Data Infrastructure
# Specify provider and remote setup for TF cloud workspace
# terraform {
#   cloud {
#     organization = "hibob"

#     workspaces {
#       name = "hibob-dev-eu-west-1-app-infra"
#     }
#   }
# }

terraform {
  backend "s3" {
    bucket = "bluebricks-tf-state"
    key    = "hibob/sqs-sns-demo/terraform.tfstate"
    region = "eu-central-1"
  }
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.55.0"
    }
  }
}

## AWS provider
provider "aws" {
  region = var.region
}

# data "tfe_outputs" "network" {
#   organization = "hibob"
#   workspace    = "hibob-dev-eu-west-1-network-infra"
# }

# data "tfe_outputs" "data" {
#   organization = "hibob"
#   workspace    = "hibob-dev-eu-west-1-data-infra"
# }

# data "tfe_outputs" "app" {
#   organization = "hibob"
#   workspace    = "hibob-dev-eu-west-1-app-infra"
# }

# data "aws_secretsmanager_secret_version" "secrets_manager_output_transifex" {
#   secret_id = module.sm.secret_id["transifex-api-key"]
# }

# data "aws_secretsmanager_secret_version" "secrets_manager_output_lokalise" {
#   secret_id = module.sm.secret_id["lokalise"]
# }

module "sns" {
  source = "../sns/sns-with-subscription"

  for_each = { for topic in local.sns_topic_config : trimprefix(topic.name, "${local.prefix}-") => topic }

  display_name                     = lookup(each.value, "display_name", null)
  sqs_failure_feedback_role_arn    = lookup(each.value, "sqs_failure_feedback_role_arn", null)
  sqs_success_feedback_sample_rate = lookup(each.value, "sqs_success_feedback_sample_rate", null)
  sqs_success_feedback_role_arn    = lookup(each.value, "sqs_success_feedback_role_arn", null)

  sns_topic_config = each.value
  tags             = local.standard_tags
}

module "sns_local" {
  source = "../sns/sns-with-subscription"

  for_each = { for topic in local.sns_topic_config_local : trimprefix(topic.name, "${local.prefix_local}-") => topic }

  display_name                     = lookup(each.value, "display_name", null)
  sqs_failure_feedback_role_arn    = lookup(each.value, "sqs_failure_feedback_role_arn", null)
  sqs_success_feedback_sample_rate = lookup(each.value, "sqs_success_feedback_sample_rate", null)
  sqs_success_feedback_role_arn    = lookup(each.value, "sqs_success_feedback_role_arn", null)

  sns_topic_config = each.value
  tags             = local.standard_tags_local
}

module "sqs" {
  source = "../sqs/sqs-with-dlq-and-sns-policy"

  for_each = { for queue in local.sqs_queue_config : trimprefix(trimsuffix(queue.name, "-${title(var.environment)}"), "${local.prefix}-") => queue }

  sqs_queue_config = each.value

  tags = local.standard_tags
}

module "sqs_local" {
  source = "../sqs/sqs-with-dlq-and-sns-policy"

  for_each = { for queue in local.sqs_queue_config_local : trimsuffix(queue.name, "-${title(format("%s-local", var.environment))}") => queue }

  sqs_queue_config = each.value

  tags = local.standard_tags_local
}
