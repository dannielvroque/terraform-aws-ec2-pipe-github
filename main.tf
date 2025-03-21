variable "regions" {
  type = map(string)
  default = {
    us-east-1 = "ami-02e136e904f3da870"
    sa-east-1 = "ami-09bc0685970d93c8d"
  }
}

# Definir múltiplos providers com alias
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "sa-east-1"
  region = "sa-east-1"
}

# Criar instâncias dinamicamente
resource "aws_instance" "instances" {
  for_each      = var.regions
  provider      = each.key == "us-east-1" ? aws.us-east-1 : aws.sa-east-1

  ami           = each.value
  instance_type = "t2.micro"
}

# Output para exibir os IPs públicos das instâncias criadas
output "instance_ips" {
  value = { for region, instance in aws_instance.instances : region => instance.public_ip }
}