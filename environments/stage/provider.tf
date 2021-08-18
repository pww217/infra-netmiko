provider "aws" {
  region     = var.region
}

terraform {
  backend "s3" {
    bucket = "pww217-s3-backend-remote"
    key    = "pww217-s3-backend-remote.state"
    region = "us-east-1"
  }
}
