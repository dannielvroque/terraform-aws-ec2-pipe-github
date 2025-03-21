# Provvedor para a região us-east-1
provider "aws" {
  alias  = "useast"
  region = "us-east-1"
}

# Provvedor para a região sa-east-1
provider "aws" {
  alias  = "saeast"
  region = "sa-east-1"
}

# Módulos de VPC
module "vpc_us" {
  source     = "./modules/vpc"
  region     = "us-east-1"   # Passando a região para o módulo
  cidr_block = var.vpc_cidr["us-east-1"]
}

module "vpc_sa" {
  source     = "./modules/vpc"
  region     = "sa-east-1"   # Passando a região para o módulo
  cidr_block = var.vpc_cidr["sa-east-1"]
}

# Módulos de Subnet
module "subnet_us" {
  source                 = "./modules/subnet"
  region                 = "us-east-1"  # Passando a região
  vpc_id                 = module.vpc_us.vpc_id
  cidr_block_a           = "10.0.1.0/24"  # CIDR para a subnet A
  cidr_block_c           = "10.0.2.0/24"  # CIDR para a subnet C
  availability_zone_a     = "us-east-1a"  # Zona de disponibilidade para a subnet A
  availability_zone_c     = "us-east-1c"  # Zona de disponibilidade para a subnet C
}

module "subnet_sa" {
  source                 = "./modules/subnet"
  region                 = "sa-east-1"  # Passando a região
  vpc_id                 = module.vpc_sa.vpc_id
  cidr_block_a           = "10.1.1.0/24"  # CIDR para a subnet A
  cidr_block_c           = "10.1.2.0/24"  # CIDR para a subnet C
  availability_zone_a     = "sa-east-1a"  # Zona de disponibilidade para a subnet A
  availability_zone_c     = "sa-east-1c"  # Zona de disponibilidade para a subnet C
}

# Módulos de Security Group
module "sg_us" {
  source                 = "./modules/security_group"
  region                 = "us-east-1"  # Passando a região
  vpc_id                 = module.vpc_us.vpc_id
  security_group_name    = "allow_ssh_ping"
  ssh_cidr_blocks       = ["0.0.0.0/0"]  # CIDR para SSH
  icmp_cidr_blocks      = ["0.0.0.0/0"]  # CIDR para ICMP
}

module "sg_sa" {
  source                 = "./modules/security_group"
  region                 = "sa-east-1"  # Passando a região
  vpc_id                 = module.vpc_sa.vpc_id
  security_group_name    = "allow_ssh_ping"
  ssh_cidr_blocks       = ["0.0.0.0/0"]  # CIDR para SSH
  icmp_cidr_blocks      = ["0.0.0.0/0"]  # CIDR para ICMP
}

# Módulos de EC2 Instances
module "ec2_instance_us_a" {
  source            = "./modules/ec2_instance"
  region            = "us-east-1"  # Passando a região para o módulo EC2
  ami_id            = var.regions["us-east-1"]  # Passando o ID da AMI para a região us-east-1
  instance_type     = "t2.micro"
  subnet_id         = module.subnet_us.subnet_a_id  # ID da subnet para us-east-1a
  security_group_ids = [module.sg_us.sg_id]  # ID do Security Group para a região us-east-1
  instance_name     = "instance-us-a"
}

module "ec2_instance_us_c" {
  source            = "./modules/ec2_instance"
  region            = "us-east-1"  # Passando a região para o módulo EC2
  ami_id            = var.regions["us-east-1"]  # Passando o ID da AMI para a região us-east-1
  instance_type     = "t2.micro"
  subnet_id         = module.subnet_us.subnet_c_id  # ID da subnet para us-east-1c
  security_group_ids = [module.sg_us.sg_id]  # ID do Security Group para a região us-east-1
  instance_name     = "instance-us-c"
}

module "ec2_instance_sa_a" {
  source            = "./modules/ec2_instance"
  region            = "sa-east-1"  # Passando a região para o módulo EC2
  ami_id            = var.regions["sa-east-1"]  # Passando o ID da AMI para a região sa-east-1
  instance_type     = "t2.micro"
  subnet_id         = module.subnet_sa.subnet_a_id  # ID da subnet para sa-east-1a
  security_group_ids = [module.sg_sa.sg_id]  # ID do Security Group para a região sa-east-1
  instance_name     = "instance-sa-a"
}

module "ec2_instance_sa_c" {
  source            = "./modules/ec2_instance"
  region            = "sa-east-1"  # Passando a região para o módulo EC2
  ami_id            = var.regions["sa-east-1"]  # Passando o ID da AMI para a região sa-east-1
  instance_type     = "t2.micro"
  subnet_id         = module.subnet_sa.subnet_c_id  # ID da subnet para sa-east-1c
  security_group_ids = [module.sg_sa.sg_id]  # ID do Security Group para a região sa-east-1
  instance_name     = "instance-sa-c"
}

output "instance_ips" {
  value = {
    us-east-1a = module.ec2_instance_us_a.public_ip
    us-east-1c = module.ec2_instance_us_c.public_ip
    sa-east-1a = module.ec2_instance_sa_a.public_ip
    sa-east-1c = module.ec2_instance_sa_c.public_ip
  }
}