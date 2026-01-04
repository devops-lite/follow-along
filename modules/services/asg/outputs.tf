output "alb_dns_name" {
  description = "DNS name of load balancer"
  value       = aws_alb.example.dns_name
}
