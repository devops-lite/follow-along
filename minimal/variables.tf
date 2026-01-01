variable "region" {
  type    = string
  default = "us-west-2"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = "vpc-0d5c492e96eec173c"
}

variable "subnet_id" {
  type        = string
  description = "Public Subnet ID"
  default     = "subnet-0573f46783092a2be"
}
