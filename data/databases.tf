data "terraform_remote_state" "mysql" {
  backend = "s3"
  config = {
    bucket = var.terraform_state_bucket_name
    key    = "@${var.aws_region}/storage/mysql/terraform.tfstate"
    region = var.terraform_state_bucket_region
  }
}
