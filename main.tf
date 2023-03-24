module "sg" {
  source          = "./modules/sg" //módulo local
  security_groups = var.security_groups
  env             = var.env
}

module "iam" {
  source       = "git::https://github.com/mllcarvalho/module-iam.git?ref=release-1.0.0" //módulo remoto com versão
  iam_policies = var.iam_policies
  iam_roles    = var.iam_roles
}

// caso dê erro 403 ao criar as roles na sua conta, verifique as permissões (Access/Scret Key ou profile)