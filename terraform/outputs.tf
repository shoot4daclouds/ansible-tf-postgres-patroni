output "bastion_public_ip" {
  description = "Public IP address of bastion instance"
  value       = aws_instance.bastion.public_ip
}
output "postgres_private_ips" {
  description = "Private IP addresses of instances"
  value       = aws_instance.postgres-ec2.*.private_ip
}
