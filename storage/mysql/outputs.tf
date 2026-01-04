output "address" {
  value       = aws_db_instance.example.address
  description = "Database endpoint address"
}

output "port" {
  value       = aws_db_instance.example.port
  description = "Database connection port"
}
