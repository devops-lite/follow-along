output "alb_dns_name" {
  description = "DNS name of load balancer"
  value       = module.asg.alb_dns_name
}
