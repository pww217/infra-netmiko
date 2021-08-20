module "sg" {
  source = "cloudposse/security-group/aws"

  vpc_id = module.vpc.vpc_id

  rules = [
    {
      type        = "ingress"
      from_port   = 5000
      to_port     = 5000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self = null
      description = "Allow HTTP from inside the security group"
    },

    {
      type        = "egress"
      from_port   = 0
      to_port     = 65535
      protocol    = "all"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null
      description = "Allow egress to anywhere"
    }
  ]
}