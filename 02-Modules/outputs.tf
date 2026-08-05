output "web_server_instance_id" {
  description = "Web Server Instance ID"
  value       = module.web_server.instance_id
}

output "web_server_public_ip" {
  description = "Web Server Public IP"
  value       = module.web_server.public_ip
}

output "web_server_public_dns" {
  description = "Web Server Public DNS"
  value       = module.web_server.public_dns
}

output "api_server_instance_id" {
  description = "API Server Instance ID"
  value       = module.api_server.instance_id
}

output "api_server_public_ip" {
  description = "API Server Public IP"
  value       = module.api_server.public_ip
}

output "api_server_public_dns" {
  description = "API Server Public DNS"
  value       = module.api_server.public_dns
}
