# Defines ECS Cluster

module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  name = var.cluster_name

  container_insights = false

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy = [
    {
      capacity_provider = var.capacity_provider
    }
  ]

  tags = {
    Environment = "Development"
  }
}

# ECS Task Definition

module "container" {
  source                       = "cloudposse/ecs-container-definition/aws"
  container_name               = "netmiko-web"
  container_image              = var.container_image
  command                      = ["python3 , main.py"]
  container_memory             = 512
  container_memory_reservation = 512
  working_directory            = "/app"
  port_mappings = [
    {
      containerPort = 5000
      hostPort      = 5000
      protocol      = "tcp"
    }
  ]
}

resource "aws_ecs_task_definition" "service" {
  family                = "netmiko"
  cpu                   = 256
  memory                = 512
  container_definitions = module.container.json_map_encoded_list
  #execution_role_arn       = "arn:aws:iam::726617996409:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  tags                     = var.tags



}