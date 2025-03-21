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

# VPC para us-east-1
resource "aws_vpc" "vpc_us" {
  provider   = aws.useast
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet_us" {
  provider   = aws.useast
  vpc_id     = aws_vpc.vpc_us.id
  cidr_block = "10.0.1.0/24"
}

# VPC para sa-east-1
resource "aws_vpc" "vpc_sa" {
  provider   = aws.saeast
  cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "subnet_sa" {
  provider   = aws.saeast
  vpc_id     = aws_vpc.vpc_sa.id
  cidr_block = "10.1.1.0/24"
}

# Security Group para us-east-1
resource "aws_security_group" "sg_us" {
  provider = aws.useast
  vpc_id   = aws_vpc.vpc_us.id
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

# Security Group para sa-east-1
resource "aws_security_group" "sg_sa" {
  provider = aws.saeast
  vpc_id   = aws_vpc.vpc_sa.id
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

# Instância para us-east-1
resource "aws_instance" "us" {
  provider      = aws.useast
  ami           = var.regions["us-east-1"]
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_us.id
  vpc_security_group_ids = [aws_security_group.sg_us.id]
}

# Instância para sa-east-1
resource "aws_instance" "sa" {
  provider      = aws.saeast
  ami           = var.regions["sa-east-1"]
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_sa.id
  vpc_security_group_ids = [aws_security_group.sg_sa.id]
}

output "instance_ips" {
  value = {
    us-east-1 = aws_instance.us.public_ip
    sa-east-1 = aws_instance.sa.public_ip
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "s3-tfsate-danniel1"
  acl    = "private"
  region = "us-east-1"  # Região do bucket
}


terraform {
  backend "s3" {
    bucket = "s3-tfsate-danniel1"     # Nome do seu bucket
    key    = "terraform.tfstate"     # Caminho do arquivo de estado dentro do bucket
    region = "us-east-1"             # Região onde o bucket está localizado
    encrypt = true                   # Habilita criptografia do estado no S3
    acl    = "private"               # Controle de acesso ao arquivo de estado
  }
}
