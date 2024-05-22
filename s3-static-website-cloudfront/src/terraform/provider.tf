provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = var.environment
      Owner       = var.Owner
    }
  }
}

provider "aws" { # mandatory for ACM + CF
  alias  = "use1"
  region = "us-east-1"

  default_tags {
    tags = {
    }
  }
}
