# Defines ECS Cluster

module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  name = var.cluster_name

  container_insights = true

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy = [
    {
      capacity_provider = var.capacity_provider
      weight            = "1"
    }
  ]

  tags = {
    Environment = "Development"
  }
}

# ECS Service Definition
resource "aws_ecs_service" "netmiko-web" {
  name            = "netmiko-web"
  cluster         = module.ecs.ecs_cluster_arn
  task_definition = aws_ecs_task_definition.netmiko-web.arn
  desired_count   = 1
  network_configuration {
    subnets        = ["subnet-03abd4c40e3a36804"]
    security_groups = ["sg-0d77fd02963fc8425"]
    assign_public_ip = true
    }
  }

# ECS Task Definition

module "container" {
  source          = "cloudposse/ecs-container-definition/aws"
  container_name  = "netmiko-web"
  container_image = var.container_image
  # command                      = ["python3 main.py"]
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

resource "aws_ecs_task_definition" "netmiko-web" {
  family                = "netmiko"
  cpu                   = 256
  memory                = 512
  container_definitions = module.container.json_map_encoded_list
  #execution_role_arn       = "arn:aws:iam::726617996409:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  tags                     = var.tags



}