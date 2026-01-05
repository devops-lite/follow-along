provider "aws" {
  region = var.region

  default_tags {
    tags = {
      creator = "terraform"
      env     = "stage"
    }
  }
}

module "asg" {
  source        = "../../../modules/services/asg"
  env           = "stage"
  vpc_name      = "stage-vpc"
  cluster_name  = "stage-asg"
  server_port   = 8080
  mysql_address = data.terraform_remote_state.mysql.outputs.address
  mysql_port    = data.terraform_remote_state.mysql.outputs.port
}

data "terraform_remote_state" "mysql" {
  backend = "s3"
  config = {
    bucket = var.terraform_state_bucket_name
    key    = "@stage/@${var.region}/storage/mysql/terraform.tfstate"
    region = var.terraform_state_bucket_region
  }
}
