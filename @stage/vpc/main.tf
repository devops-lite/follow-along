provider "aws" {
  region = var.region

  default_tags {
    tags = {
      creator = "terraform"
      env     = "stage"
    }
  }
}

module "vpc" {
  source   = "../../modules/vpc"
  vpc_name = "stage-vpc"
}
