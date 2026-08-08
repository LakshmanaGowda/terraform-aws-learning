output "web_server_instance_id" {
  description = "Web server EC2 instance ID"
  value       = module.web_server.instance_id
}

output "web_server_public_ip" {
  description = "Web server public IP"
  value       = module.web_server.public_ip
}

output "web_server_public_dns" {
  description = "Web server public DNS"
  value       = module.web_server.public_dns
}

output "api_server_instance_id" {
  description = "API server EC2 instance ID"
  value       = module.api_server.instance_id
}

output "api_server_public_ip" {
  description = "API server public IP"
  value       = module.api_server.public_ip
}

output "api_server_public_dns" {
  description = "API server public DNS"
  value       = module.api_server.public_dns
}
