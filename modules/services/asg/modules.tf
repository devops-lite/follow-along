module "data" {
  source   = "../../data"
  env      = var.env
  vpc_name = var.vpc_name
}
