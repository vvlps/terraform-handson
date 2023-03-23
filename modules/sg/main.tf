data "aws_vpc" "vpc" {
  default = true
}

resource "aws_security_group" "alb-sg" {
  for_each    = var.security_groups
  name        = each.key
  description = each.value.description
  vpc_id      = data.aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = [data.aws_vpc.vpc.cidr_block]
    }
  }

  dynamic "egress" {
    for_each = each.value.egress
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.protocol == "-1" ? ["0.0.0.0/0"] : [data.aws_vpc.vpc.cidr_block]
    }
  }

  tags = merge(
  local.tags,
  {
    Name = each.key
  }
  )
}