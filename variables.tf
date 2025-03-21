variable "regions" {
  type = map(string)
  default = {
    us-east-1 = "ami-02e136e904f3da870"
    sa-east-1 = "ami-09bc0685970d93c8d"
  }
}

variable "vpc_cidr" {
  description = "CIDR blocks for the VPCs in different regions"
  type        = map(string)
  default = {
    "us-east-1" = "10.0.0.0/16"
    "sa-east-1" = "10.1.0.0/16"
  }
}

variable "subnet_cidr" {
  type = map(map(string))
  default = {
    us-east-1 = {
      "us-east-1a" = "10.0.1.0/24"
      "us-east-1c" = "10.0.2.0/24"
    }
    sa-east-1 = {
      "sa-east-1a" = "10.1.1.0/24"
      "sa-east-1c" = "10.1.2.0/24"
    }
  }
}

variable "availability_zones" {
  type = map(list(string))
  default = {
    us-east-1 = ["us-east-1a", "us-east-1c"]
    sa-east-1 = ["sa-east-1a", "sa-east-1c"]
  }
}

variable "ami_ids" {
  description = "Map of AMI IDs for each region"
  type = map(string)
  default = {
    "us-east-1" = "ami-0c55b159cbfafe1f0"  # Exemplo de AMI para us-east-1
    "sa-east-1" = "ami-0c55b159cbfafe1f0"  # Exemplo de AMI para sa-east-1
  }
}

