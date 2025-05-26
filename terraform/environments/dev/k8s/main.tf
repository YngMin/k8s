module "k8s" {
  source = "../../../module/k8s"

  ami                       = var.ami
  environment               = var.environment
  key_name                  = var.key_name
  master_availability_zone  = var.master_availability_zone
  master_instance_type      = var.master_instance_type
  vpc_security_group_ids    = [data.terraform_remote_state.vpc.outputs.main_security_group_id]
  worker_availability_zones = var.worker_availability_zones
  worker_count              = var.worker_count
  worker_instance_type      = var.worker_instance_type
  master_init_script_path   = "../../../../script/environments/dev/k8s/master_init.sh"
  worker_init_script_path   = "../../../../script/environments/dev/k8s/worker_init.sh.tftpl"
  private_subnet_ids        = data.terraform_remote_state.vpc.outputs.private_subnet_ids
}
