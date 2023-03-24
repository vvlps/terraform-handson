variable "security_groups" {
  type = map(any)
}

variable "env" {
  type = string
}

variable "iam_policies" {
  type = map(any)

}

variable "iam_roles" {
  type = map(any)

}