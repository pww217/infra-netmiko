# General
variable "region" {
  default = "us-east-1"
}

variable "tags" {}
variable "user_name" {}

# Backend
variable "bucket_name" {}

# VPC
variable "cidr" {}
variable "azs" {}
variable "private_subnets" {}
variable "public_subnets" {}