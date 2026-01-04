data "aws_caller_identity" "current" {}

locals {
  iam_user = regex("arn:aws:iam::\\d+:user/(.*)$", data.aws_caller_identity.current.arn)[0]
  env      = var.env != "" ? var.env : local.iam_user
}
