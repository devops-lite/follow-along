output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "public subnet IDs"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
  description = "private subnet IDs"
  value       = aws_subnet.private_subnets[*].id
}
