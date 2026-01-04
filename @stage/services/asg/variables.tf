variable "region" {
  type    = string
  default = "us-west-2"
}

variable "terraform_state_bucket_name" {
  type = string
  # use your unique bucket name
  default = "devops-terraform-state-e7674df2-4976-0e83-3463-dcf97a087f97"
}

variable "terraform_state_bucket_region" {
  type    = string
  default = "us-west-2"
}
