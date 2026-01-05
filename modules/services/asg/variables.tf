variable "env" {
  description = "environment name: [ci, stage, prod]. For dev env, current aws IAM username is used"
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
