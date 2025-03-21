variable "regions" {
  type = map(string)
  default = {
    us-east-1 = "ami-02e136e904f3da870"
    sa-east-1 = "ami-09bc0685970d93c8d"
  }
}

variable "vpc_cidr" {
  type = map(string)
  default = {
    "us-east-1" = "10.0.0.0/16"
    "sa-east-1" = "10.1.0.0/16"
  }
}

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
  providers  = { aws = aws.useast }
  cidr_block = var.vpc_cidr["us-east-1"]
}

module "vpc_sa" {
  source     = "./modules/vpc"
  providers  = { aws = aws.saeast }
  cidr_block = var.vpc_cidr["sa-east-1"]
}

# Módulos de Subnet
module "subnet_us" {
  source    = "./modules/subnet"
  providers = { aws = aws.useast }
  vpc_id    = module.vpc_us.vpc_id
}

module "subnet_sa" {
  source    = "./modules/subnet"
  providers = { aws = aws.saeast }
  vpc_id    = module.vpc_sa.vpc_id
}

# Módulos de Security Group
module "sg_us" {
  source    = "./modules/security_group"
  providers = { aws = aws.useast }
  vpc_id    = module.vpc_us.vpc_id
}

module "sg_sa" {
  source    = "./modules/security_group"
  providers = { aws = aws.saeast }
  vpc_id    = module.vpc_sa.vpc_id
}

# Módulos de EC2 Instances
module "ec2_instance_us_a" {
  source        = "./modules/ec2_instance"
  providers     = { aws = aws.useast }
  ami_id        = var.regions["us-east-1"]
  instance_type = "t2.micro"
  subnet_id     = module.subnet_us.subnet_id
  security_group_ids = [module.sg_us.sg_id]
}

module "ec2_instance_us_c" {
  source        = "./modules/ec2_instance"
  providers     = { aws = aws.useast }
  ami_id        = var.regions["us-east-1"]
  instance_type = "t2.micro"
  subnet_id     = module.subnet_us.subnet_id
  security_group_ids = [module.sg_us.sg_id]
}

module "ec2_instance_sa_a" {
  source        = "./modules/ec2_instance"
  providers     = { aws = aws.saeast }
  ami_id        = var.regions["sa-east-1"]
  instance_type = "t2.micro"
  subnet_id     = module.subnet_sa.subnet_id
  security_group_ids = [module.sg_sa.sg_id]
}

module "ec2_instance_sa_c" {
  source        = "./modules/ec2_instance"
  providers     = { aws = aws.saeast }
  ami_id        = var.regions["sa-east-1"]
  instance_type = "t2.micro"
  subnet_id     = module.subnet_sa.subnet_id
  security_group_ids = [module.sg_sa.sg_id]
}

output "instance_ips" {
  value = {
    us-east-1a = module.ec2_instance_us_a.public_ip
    us-east-1c = module.ec2_instance_us_c.public_ip
    sa-east-1a = module.ec2_instance_sa_a.public_ip
    sa-east-1c = module.ec2_instance_sa_c.public_ip
  }
}