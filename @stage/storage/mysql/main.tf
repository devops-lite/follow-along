provider "aws" {
  region = var.region

  default_tags {
    tags = {
      creator = "terraform"
      env     = "stage"
    }
  }
}

module "mysql" {
  source               = "../../../modules/storage/mysql"
  env                  = "stage"
  instance_name_prefix = "stage-mysql"
}
