terraform {
  backend "s3" {
    # ! replace this with your unique bucket name
    bucket         = "devops-terraform-state-e7674df2-4976-0e83-3463-dcf97a087f97"
    key            = "@stage/@us-west-2/vpc/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "devops-terraform-locks"
    encrypt        = true
  }
}
