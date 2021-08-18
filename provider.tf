provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}

terraform {
  backend "s3" {
    bucket = "netmiko-ebs-tfremotestate"
    key    = "netmiko-ebs-tfremotestate.tfstate"
    region = "us-east-1"
  }
}
