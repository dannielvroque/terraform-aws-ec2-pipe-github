terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}