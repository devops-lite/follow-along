output "secret_id" {
  value       = aws_secretsmanager_secret.devops.id
  description = "Secret ID"
}
