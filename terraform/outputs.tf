output "postgres_public_ips" {
  description = "Public IP addresses of instances"
  value       = aws_instance.postgres-ec2.public_ip
}