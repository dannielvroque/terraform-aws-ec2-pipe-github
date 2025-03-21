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

resource "aws_instance" "instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = var.instance_name
  }
}

output "public_ip" {
  value = aws_instance.instance.public_ip
}
