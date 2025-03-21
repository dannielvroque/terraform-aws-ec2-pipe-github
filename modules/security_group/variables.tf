variable "region" {
  description = "A AWS region to deploy resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  default     = "allow_ssh_ping"
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks to allow SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "icmp_cidr_blocks" {
  description = "CIDR blocks to allow ICMP (ping) access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
