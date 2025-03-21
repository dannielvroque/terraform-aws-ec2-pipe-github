variable "regions" {
  type = map(string)
  default = {
    us-east-1 = "ami-12345678"
    sa-east-1 = "ami-87654321"
  }
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "sa-east-1"
  region = "sa-east-1"
}

# Mapeamento de alias dos providers
locals {
  providers_map = {
    us-east-1 = aws.us-east-1
    sa-east-1 = aws.sa-east-1
  }
}

# Criar instâncias dinamicamente em todas as regiões definidas
resource "aws_instance" "instances" {
  for_each      = var.regions
  provider      = local.providers_map[each.key] # Resolvendo o provider dinamicamente
  ami           = each.value
  instance_type = "t2.micro"
}