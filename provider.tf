provider "aws" {
  region     = var.region
}

terraform {
  backend "s3" {
    bucket = "netmiko-ebs-tfremotestate"
    key    = "netmiko-ebs-tfremotestate.tfstate"
    region = "us-east-1"
  }
}
