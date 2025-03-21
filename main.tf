variable "regions" {
  type = map(string)
  default = {
    us-east-1 = "ami-02e136e904f3da870"
    sa-east-1 = "ami-09bc0685970d93c8d"
  }
}

provider "aws" {
  alias  = "useast"
  region = "us-east-1"
}

provider "aws" {
  alias  = "saeast"
  region = "sa-east-1"
}

resource "aws_instance" "us" {
  provider      = aws.useast
  ami           = var.regions["us-east-1"]
  instance_type = "t2.micro"
}

resource "aws_instance" "sa" {
  provider      = aws.saeast
  ami           = var.regions["sa-east-1"]
  instance_type = "t2.micro"
}

output "instance_ips" {
  value = {
    us-east-1 = aws_instance.us.public_ip
    sa-east-1 = aws_instance.sa.public_ip
  }
}