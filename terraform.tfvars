env = "dev"

security_groups = {
  alb-sg = {
    description = "SG para ALB"

    ingress = {
      http = {
        description = "ingress ALB http"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
      }
    }
    egress = {
      all = {
        description = "egress ALB all"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
      }
    }
  }
}

iam_policies = {
  ecs-task-policy = {
    document = "iam-documents/policy/ecs-task-policy.json"
    path     = "/"
  }
  ecs-execution-policy = {
    document = "iam-documents/policy/ecs-execution-policy.json"
    path     = "/"
  }
}
iam_roles = {
  ecs-task-role = {
    trust_policy_document = "iam-documents/trust/ecs-trust.json"
    attached_policies     = ["arn:aws:iam::ACCOUNT_ID:policy/ecs-task-policy"]
  }
  ecs-execution-role = {
    trust_policy_document = "iam-documents/trust/ecs-trust.json"
    attached_policies     = ["arn:aws:iam::ACCOUNT_ID:policy/ecs-execution-policy"]
  }
}