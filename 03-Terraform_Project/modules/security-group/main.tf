locals {
  common_tags = {
    Environment = terraform.workspace
    ManagedBy   = "Terraform"
    Project     = "Terraform Final Project"
  }
}

resource "aws_security_group" "this" {
  name        = var.security_group_name
  description = var.description

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

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(
  local.common_tags,
  {
    Name = var.security_group_name
  }
 )

}
