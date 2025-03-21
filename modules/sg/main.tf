variable "vpc_id" {
  type = string
}

resource "aws_security_group" "sg" {
  vpc_id   = var.vpc_id
  name     = "allow_ssh_ping"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "sg_id" {
  value = aws_security_group.sg.id
}
