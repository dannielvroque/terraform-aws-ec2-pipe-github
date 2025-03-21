variable "region" {
  description = "A AWS region to deploy resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the subnets will be created"
  type        = string
}

variable "cidr_block_a" {
  description = "CIDR block for subnet A"
  type        = string
}

variable "cidr_block_c" {
  description = "CIDR block for subnet C"
  type        = string
}

variable "availability_zone_a" {
  description = "Availability zone for subnet A"
  type        = string
}

variable "availability_zone_c" {
  description = "Availability zone for subnet C"
  type        = string
}
