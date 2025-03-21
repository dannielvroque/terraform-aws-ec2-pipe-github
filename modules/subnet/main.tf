variable "vpc_id" {
  type = string
}

resource "aws_subnet" "subnet_a" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet_c" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1c"
}

output "subnet_id" {
  value = aws_subnet.subnet_a.id
}
