variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "ami" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "master_availability_zone" {
  description = "Availability zone for the master node"
  type        = string
}

variable "master_instance_type" {
  description = "Instance type for the master node"
  type        = string
}

variable "key_name" {
  description = "Key name"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "VPC security group IDs"
  type        = list(string)
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
}

variable "worker_availability_zones" {
  description = "Availability zones for the worker nodes"
  type        = list(string)
}

variable "worker_instance_type" {
  description = "Instance type for the worker nodes"
  type        = string
}

variable "master_init_script_path" {
  description = "Path to the master initialization script"
  type        = string
}

variable "worker_init_script_path" {
  description = "Path to the worker initialization script"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}
