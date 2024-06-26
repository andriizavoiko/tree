terraform {
  backend "s3" {
    bucket = "bluebricks-tf-state"
    key    = "hibob/hibob-sqs-local-Compensation/demo/terraform.tfstate"
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

module "sqs_local" {
  source = "../sqs/sqs-with-dlq-and-sns-policy"

  for_each = { for queue in local.sqs_queue_config_local : trimsuffix(queue.name, "-${title(format("%s-local", var.environment))}") => queue }

  sqs_queue_config = each.value

  tags = local.standard_tags_local
}
