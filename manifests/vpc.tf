module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  cidr = "10.0.0.0/27"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.0.0/28"]
  public_subnets  = ["10.0.0.16/28"]

  tags = {
    Environment = "Development"
  }
}