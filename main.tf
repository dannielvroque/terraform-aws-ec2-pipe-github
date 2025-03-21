provider "aws" {
  region = "us-east-1" # Substitua pela sua região
}

resource "aws_instance" "web" {
  ami           = "ami-02e136e904f3da870" # Substitua por uma AMI válida da sua região
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-EC2"
  }
}