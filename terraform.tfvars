region = "us-east-1"

tags = {
  Environment = "Development"
}

bucket_name = "pww217-s3-backend-remote"

# ec2-pw = 1KhWI*72l&Z%q

cidr            = "10.0.0.0/27"
azs             = ["us-east-1a", "us-east-1b"]
private_subnets = ["10.0.0.0/28"]
public_subnets  = ["10.0.0.16/28"]
user_name       = "terraform"

cluster_name      = "default"
capacity_provider = "FARGATE"
task_name         = "netmiko-web"
container_image   = "https://hub.docker.com/pww217/netmiko-run"