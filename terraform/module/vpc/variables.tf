variable "cidr_numeral" {
  description = "The VPC CIDR numeral (10.x.0.0/16)"
  type        = number
}

variable "cidr_numeral_public" {
  default = {
    "0" = "0"
    "1" = "4"
    "2" = "8"
    "3" = "12"
  }
}

variable "cidr_numeral_private" {
  default = {
    "0" = "16"
    "1" = "32"
    "2" = "48"
    "3" = "64"
  }
}

variable "cidr_numeral_private_db" {
  default = {
    "0" = "100"
    "1" = "101"
    "2" = "102"
    "3" = "103"
  }
}

variable "account_name" {
  description = "Name of the account"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "bastion_ami" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "bastion_availability_zone" {
  description = "Availability zone for the bastion host"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type for the bastion host"
  type        = string
}

variable "bastion_key_name" {
  description = "Key name for the bastion host"
  type        = string
}

variable "home_ip" {
  description = "Home IP for security group rules"
  type        = string
}