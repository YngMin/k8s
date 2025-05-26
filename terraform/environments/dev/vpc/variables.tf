variable "account_name" {
  description = "Name of the account"
  type        = string
  default     = "yngmin-k8s"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "cidr_numeral" {
  description = "The VPC CIDR numeral (10.x.0.0/16)"
  type        = number
  default     = 0
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
  description = "Home IP address for SSH access to the bastion host"
  type        = string
}
