data "aws_caller_identity" "current" {}

locals {
  iam_user_regex = regex("arn:aws:iam::\\d+:user/(.*)$", data.aws_caller_identity.current.arn)
  iam_user       = length(local.iam_user_regex) > 0 ? local.iam_user_regex[0] : "unknown_user"
  env_or_user    = var.env != "" ? var.env : replace("dev_${local.iam_user}", "/[^a-zA-Z0-9]+/", "_")
}
