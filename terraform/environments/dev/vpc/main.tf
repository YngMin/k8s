module "vpc" {
  source                    = "../../../module/vpc"
  account_name              = var.account_name
  cidr_numeral              = var.cidr_numeral
  environment               = var.environment
  bastion_ami               = var.bastion_ami
  bastion_availability_zone = var.bastion_availability_zone
  bastion_instance_type     = var.bastion_instance_type
  bastion_key_name          = var.bastion_key_name
  home_ip                   = var.home_ip
}
