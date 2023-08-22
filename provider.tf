provider "aws" {
  region = var.region
  default_tags {
    tags = {
      IaC         = "Terraform"
      Application = "Netmiko"
      Environment = "Prod"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "pww217-s3-backend-remote"
    key    = "pww217-s3-backend-remote.state"
    region = "us-east-1"
  }
}