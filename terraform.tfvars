env = "dev"

security_groups = {
  alb-sg = {
    description = "SG para ALB"

    ingress = {
      https = {
        description = "ingress ALB https"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
      }
      http = {
        description = "ingress ALB http"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
      }
    }
    egress = {
      https = {
        description = "egress ALB https"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
      }
      http = {
        description = "egress ALB http"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
      }
    }
  }
  ec2-sg = {
    description = "SG para EC2"

    ingress = {
      http = {
        description = "ingress ALB https"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
      }
    }
    egress = {
      https = {
        description = "egress ALB https"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
      }
    }
  }
}