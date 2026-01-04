provider "aws" {
  region = var.region

  default_tags {
    tags = {
      creator = "terraform"
    }
  }
}

module "mysql" {
  source = "../../../modules/storage/mysql"
  env    = "stage"
}
