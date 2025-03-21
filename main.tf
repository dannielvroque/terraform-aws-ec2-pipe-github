variable "regions" {
  type = map(string)
  default = {
    us-east-1 = "ami-02e136e904f3da870"
    sa-east-1 = "ami-09bc0685970d93c8d"
  }
}

# Definição dos providers com alias
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "sa-east-1"
  region = "sa-east-1"
}

# Criar instâncias dinamicamente com providers explícitos
resource "aws_instance" "instances" {
  for_each      = var.regions
  provider      = aws.us-east-1 # Default para evitar erro de compilação

  ami           = each.value
  instance_type = "t2.micro"

  # Escolher o provider correto dependendo da região
  lifecycle {
    ignore_changes = [provider]
  }

  depends_on = [
    aws_instance.instance_us,
    aws_instance.instance_sa
  ]
}

# Instâncias específicas para cada região com providers explícitos
resource "aws_instance" "instance_us" {
  provider      = aws.us-east-1
  ami           = var.regions["us-east-1"]
  instance_type = "t2.micro"
}

resource "aws_instance" "instance_sa" {
  provider      = aws.sa-east-1
  ami           = var.regions["sa-east-1"]
  instance_type = "t2.micro"
}