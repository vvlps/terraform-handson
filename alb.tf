data "aws_subnets" "subnets" { //consultando as subnets da conta e filtrando apenas as que tem o nome ecs-cluster
  filter {
    name   = "tag:Name"
    values = ["ecs-cluster"]
  }
}

data "aws_vpc" "vpc" { //consulta as infos de vpc
  default = true
}

resource "aws_lb" "alb" {
  name               = "terraform-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [module.sg.security_group_id["alb-sg"]]
  subnets            = data.aws_subnets.subnets.ids

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "alb_target" {
  name        = "terraform-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "3"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target.arn
  }
}