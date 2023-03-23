module "sg" {
  source          = "./modules/sg"
  security_groups = var.security_groups
  env             = var.env
}