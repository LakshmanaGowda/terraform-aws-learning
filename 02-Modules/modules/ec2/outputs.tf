output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "Public IP"
  value       = aws_instance.web.public_ip
}

output "public_dns" {
  description = "Public DNS"
  value       = aws_instance.web.public_dns
}
