variable "aws_access_key" {
  default = "${{ secrets.AWS_ACCESS_KEY }}}"
variable "aws_secret_key" {
  default = "${{ secrets.AWS_SECRET_ACCESS_KEY }}}"
variable "key_name" {}
variable "key_dir" {}

variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {}