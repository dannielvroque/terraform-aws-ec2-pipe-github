terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Definindo o provedor AWS para o módulo
provider "aws" {
  region = var.region  # A região será passada do módulo principal
}

resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
  name   = var.security_group_name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr_blocks
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.icmp_cidr_blocks
  }
}

output "sg_id" {
  value = aws_security_group.sg.id
}
