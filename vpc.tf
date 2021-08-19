module "vpc" {
  name = "main"
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  tags = var.tags
}