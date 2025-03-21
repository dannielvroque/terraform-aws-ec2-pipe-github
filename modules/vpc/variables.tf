variable "region" {
  description = "A AWS region to deploy resources"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}
