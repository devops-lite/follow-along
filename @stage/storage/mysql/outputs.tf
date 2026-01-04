output "address" {
  value       = module.mysql.address
  description = "Database endpoint address"
}

output "port" {
  value       = module.mysql.port
  description = "Database connection port"
}
