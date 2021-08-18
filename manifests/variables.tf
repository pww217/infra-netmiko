variable "region" {
  default = "us-east-1"
}

variable "env_container_type" {}


variable "env_container_tags" {
  type = map(string)
}

variable "env_container_count" {
  type = number
}