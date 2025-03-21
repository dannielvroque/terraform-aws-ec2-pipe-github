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

resource "aws_subnet" "subnet_a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block_a
  availability_zone = var.availability_zone_a
}

resource "aws_subnet" "subnet_c" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block_c
  availability_zone = var.availability_zone_c
}

output "subnet_a_id" {
  value = aws_subnet.subnet_a.id
}

output "subnet_c_id" {
  value = aws_subnet.subnet_c.id
}
