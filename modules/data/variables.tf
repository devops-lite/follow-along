variable "env" {
  description = "environment name: [dev_xxx, ci, stage, prod]"
  type        = string
  default     = ""
  validation {
    condition     = contains(["", "ci", "stage", "prod"], var.env) || startswith(var.env, "dev_")
    error_message = "Invalid environment name"
  }
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = ""
}
