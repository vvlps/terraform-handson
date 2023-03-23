output "security_group_id" {
    value = [ for sg in aws_security_group.alb-sg : sg.id]
}

output "security_group_arn" {
    value = [ for sg in aws_security_group.alb-sg : sg.arn]
}