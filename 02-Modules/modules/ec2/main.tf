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

locals {
  common_tags = {
    Environment = terraform.workspace
    ManagedBy   = "Terraform"
    Project     = "Terraform Modules Learning"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "${terraform.workspace}-${var.instance_name}-sg"
  description = "Security Group for ${var.instance_name}"

  dynamic "ingress" {
    for_each = var.ingress_ports

    content {
      description = "Allow Port ${ingress.value}"

      from_port = ingress.value
      to_port   = ingress.value

      protocol = "tcp"

      cidr_blocks = ["0.0.0.0/0"]
    }
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
      Name = "${terraform.workspace}-${var.instance_name}-sg"
    }
  )
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = merge(
    local.common_tags,
    {
      Name = "${terraform.workspace}-${var.instance_name}"
    }
  )
}
