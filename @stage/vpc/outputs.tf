output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "private subnet IDs"
  value       = module.vpc.private_subnets
}
