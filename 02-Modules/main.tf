terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.15.0"

  backend "s3" {
    bucket = "terraform-state-lakshmana-ap-south-1"
    key    = "02-Modules/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = var.aws_region
}

module "web_server" {
  source = "./modules/ec2"

  instance_name = "web-server"
  instance_type = "t2.micro"
  ingress_ports = [22, 80, 443]
}

module "api_server" {
  source = "./modules/ec2"

  instance_name = "api-server"
  instance_type = "t2.micro"
  ingress_ports = [22, 5000]
}
