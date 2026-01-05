variable "env" {
  description = "environment name: [dev_xxx, ci, stage, prod]"
  type        = string
  default     = ""
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "cluster name for naming resources"
  type        = string
}

variable "server_port" {
  type    = number
  default = 8080
}

variable "mysql_address" {
  description = "mysql address"
  type        = string
}

variable "mysql_port" {
  description = "mysql port"
  type        = number
}
