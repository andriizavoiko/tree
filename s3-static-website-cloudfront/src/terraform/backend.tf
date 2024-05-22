terraform {
  backend "s3" {
    bucket  = "bluebricks-tf-state"
    key     = "terraform/state"
    region  = "eu-central-1" # Replace with your preferred region
    encrypt = true
  }
}
