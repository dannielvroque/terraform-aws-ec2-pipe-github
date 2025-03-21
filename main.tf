provider "aws" {
  region = "us-east-1" # Substitua pela sua região
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0" # Substitua por uma AMI válida da sua região
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-EC2"
  }
}