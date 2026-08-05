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

module "web_server" {
  source = "./modules/ec2"

  instance_name = "web-server"
  instance_type = "t2.micro"
}

module "api_server" {
  source = "./modules/ec2"

  instance_name = "api-server"
  instance_type = "t2.micro"
}
