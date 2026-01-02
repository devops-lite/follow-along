output "terraform_state_bucket" {
  description = "Terraform state bucket name"
  value       = aws_s3_bucket.terraform_state.id
}

output "terraform_locks_table" {
  description = "DynamoDB table for terraform locks"
  value       = aws_dynamodb_table.terraform_locks.id
}
