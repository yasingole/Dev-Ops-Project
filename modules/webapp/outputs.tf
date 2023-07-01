output "alb_dns_name" {
  value = aws_lb.webapp_alb.dns_name
}

output "private_instance_ids" {
  value = aws_instance.webapp_instance[*].id
}

output "private_instance_private_ips" {
  value = aws_instance.webapp_instance[*].private_ip
}