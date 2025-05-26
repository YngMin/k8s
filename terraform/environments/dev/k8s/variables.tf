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

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "local_pem_path" {
  description = "Local path to the PEM file for SSH access"
  type        = string
}

variable "remote_state" {
  description = "Remote state configuration"
  default = {
    vpc = {
      bucket = "yngmin-k8s-dev-tfstate"
      key    = "terraform/environments/dev/vpc/terraform.tfstate"
      region = "ap-northeast-2"
    }
  }
}
