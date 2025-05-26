output "vpc_id" {
  value = module.vpc.vpc_id
}

output "main_security_group_id" {
  value = module.vpc.main_security_group_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "private_db_subnet_ids" {
  value = module.vpc.private_db_subnet_ids
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "bastion_public_ip" {
  value = module.vpc.bastion_public_ip
}
