resource "aws_ecs_cluster" "cluster" {
  name = "terraform-cluster"
}

data "template_file" "nginx_template" { //pega os valores do arquivo e aplica no recurso da task definition
  template = file("${path.module}/ecs-documents/task-definition.json")
  vars = {
    image = "nginx:latest"
    env   = var.env
  }
}

resource "aws_ecs_task_definition" "task" {
  family                   = "nginx-container"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions    = data.template_file.nginx_template.rendered
  execution_role_arn       = module.iam.role_arn["ecs-execution-role"]
  task_role_arn            = module.iam.role_arn["ecs-task-role"]
}

resource "aws_ecs_service" "service" {
  name            = "service-nginx"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.alb_target.arn
    container_name   = "nginx-container"
    container_port   = 80
  }

  network_configuration {
    subnets          = data.aws_subnets.subnets.ids
    security_groups  = [module.sg.security_group_id["alb-sg"]]
    assign_public_ip = true
  }
}