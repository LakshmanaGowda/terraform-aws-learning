terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.15.0"
}

provider "aws" {
  region = var.aws_region
}

locals {
  common_tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
    Project     = "Terraform Learning"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = merge(
    local.common_tags,
    {
      Name = var.instance_name
    }
  )
}

resource "aws_security_group" "web_sg" {
  name        = "terraform-web-sg"
  description = "Security Group for Terraform Demo"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Backend API"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "terraform-web-sg"
    }
  )
}

resource "aws_eip" "web_ip" {
  instance = aws_instance.web.id

  tags = merge(
    local.common_tags,
    {
      Name = "terraform-eip"
    }
  )
  
}

