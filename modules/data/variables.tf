variable "env" {
  description = "environment name: [ci, stage, prod]. For local env, current aws IAM username is used"
  type        = string
  default     = ""
}
