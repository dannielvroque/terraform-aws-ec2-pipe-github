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

resource "aws_subnet" "subnet_us_a" {
  provider   = aws.useast
  vpc_id     = aws_vpc.vpc_us.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet_us_c" {
  provider   = aws.useast
  vpc_id     = aws_vpc.vpc_us.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1c"
}

# VPC para sa-east-1
resource "aws_vpc" "vpc_sa" {
  provider   = aws.saeast
  cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "subnet_sa_a" {
  provider   = aws.saeast
  vpc_id     = aws_vpc.vpc_sa.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "sa-east-1a"
}

resource "aws_subnet" "subnet_sa_c" {
  provider   = aws.saeast
  vpc_id     = aws_vpc.vpc_sa.id
  cidr_block = "10.1.2.0/24"
  availability_zone = "sa-east-1c"
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

# Instância para us-east-1 na zona "us-east-1a"
resource "aws_instance" "us_a" {
  provider      = aws.useast
  ami           = var.regions["us-east-1"]
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_us_a.id
  vpc_security_group_ids = [aws_security_group.sg_us.id]
}

# Instância para us-east-1 na zona "us-east-1c"
resource "aws_instance" "us_c" {
  provider      = aws.useast
  ami           = var.regions["us-east-1"]
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_us_c.id
  vpc_security_group_ids = [aws_security_group.sg_us.id]
}

# Instância para sa-east-1 na zona "sa-east-1a"
resource "aws_instance" "sa_a" {
  provider      = aws.saeast
  ami           = var.regions["sa-east-1"]
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_sa_a.id
  vpc_security_group_ids = [aws_security_group.sg_sa.id]
}

# Instância para sa-east-1 na zona "sa-east-1c"
resource "aws_instance" "sa_c" {
  provider      = aws.saeast
  ami           = var.regions["sa-east-1"]
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_sa_c.id
  vpc_security_group_ids = [aws_security_group.sg_sa.id]
}

output "instance_ips" {
  value = {
    us-east-1a = aws_instance.us_a.public_ip
    us-east-1c = aws_instance.us_c.public_ip
    sa-east-1a = aws_instance.sa_a.public_ip
    sa-east-1c = aws_instance.sa_c.public_ip
  }
}

# Criação do bucket S3 com um nome único
resource "aws_s3_bucket" "terraform_state" {
  bucket = "s3-tfsate-danniel-unique123"  # Nome exclusivo para o bucket
}

resource "aws_s3_bucket_acl" "terraform_state_acl" {
  bucket = aws_s3_bucket.terraform_state.bucket
  acl    = "private"
}

