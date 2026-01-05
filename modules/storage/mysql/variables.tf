variable "env" {
  description = "environment name: [dev_xxx, ci, stage, prod]"
  type        = string
  default     = ""
}

variable "instance_name_prefix" {
  default = "DB instance name prefix"
  type    = string
}
