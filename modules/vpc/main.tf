terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Declaração do provedor para ser configurado no módulo pai
provider "aws" {
  region = var.region  # A região será passada do módulo principal
}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}