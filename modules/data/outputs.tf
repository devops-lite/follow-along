output "env_or_user" {
  description = "env name or IAM user name"
  value       = local.env_or_user
}

output "iam_user" {
  description = "IAM user name if available. 'unknown_user' otherwise"
  value       = local.iam_user
}

output "ami_ubuntu_minimal_arm64" {
  value = data.aws_ami.ubuntu_minimal_arm64.id
}

output "ami_ubuntu_server_arm64" {
  value = data.aws_ami.ubuntu_server_arm64.id
}

output "vpc_id" {
  description = "VPC ID"
  value       = data.aws_vpc.this.id
}

output "public_subnets" {
  description = "public subnet IDs"
  value       = data.aws_subnets.public.ids
}

output "private_subnets" {
  description = "private subnet IDs"
  value       = data.aws_subnets.private.ids
}

output "devops_secrets" {
  description = "devops secrets (yaml)"
  value       = data.aws_secretsmanager_secret_version.devops.secret_string
}
