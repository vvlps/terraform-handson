output "security_group_id" {
    value = {for k, v in aws_security_group.alb-sg : k => v.id}
}

output "security_group_arn" {
    value = {for k, v in aws_security_group.alb-sg : k => v.arn}
}