terraform {
  required_version = ">= 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "web_security_group" {
  source = "./modules/security-group"

  security_group_name = "web-server-sg"
  description         = "Security Group for web server"

  ingress_ports = [22, 80, 443]
}

module "web_server" {
  source = "./modules/ec2"

  instance_name = "web-server"
  instance_type = "t2.micro"

  security_group_id = module.web_security_group.security_group_id

  user_data = <<-EOF
    #!/bin/bash

    apt-get update -y
    apt-get install -y apache2

    systemctl enable apache2
    systemctl start apache2

    echo "<h1>Terraform Web Server</h1>" > /var/www/html/index.html
    echo "<p>Deployed using Terraform User Data</p>" >> /var/www/html/index.html
  EOF
}

module "api_security_group" {
  source = "./modules/security-group"

  security_group_name = "api-server-sg"
  description         = "Security Group for API server"

  ingress_ports = [22, 5000]
}

module "api_server" {
  source = "./modules/ec2"

  instance_name = "api-server"
  instance_type = "t2.micro"

  security_group_id = module.api_security_group.security_group_id
}
