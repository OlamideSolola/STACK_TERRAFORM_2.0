

#------------ output for the load balancer dns --------#

output "alb_dns_name" {
  value       = aws_lb.Clixx-App-lb.dns_name
  description = "The domain name of the load balancer"
}

output "db_endpoint" {
  value = aws_db_instance.Clixx_database_instance.*.endpoint
}

output "Route53" {
  value       = data.aws_route53_zone.domain_name.name
  description = "The domain name of the Route53"
}

output "aws_route53_record" {
  value       = aws_route53_record.www.name
}