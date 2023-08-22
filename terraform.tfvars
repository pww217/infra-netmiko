tags = {
  Environment = "Development"
}

task_name         = "netmiko-web-dev"

capacity_provider = "FARGATE_SPOT"

desired_container_count = 1

# General
region = "us-east-1"

# Backend
bucket_name = "pww217-s3-backend-remote"

# VPC
cidr            = "10.0.0.0/27"
azs             = ["us-east-1a", "us-east-1b"]
private_subnets = ["10.0.0.0/28"]
public_subnets  = ["10.0.0.16/28"]
user_name       = "terraform"

# ECS
cluster_name      = "default"
container_image   = "pww217/netmiko-web"