resource "aws_instance" "master" {
  ami                         = var.ami
  subnet_id                   = var.private_subnet_ids[0]
  associate_public_ip_address = true
  availability_zone           = var.master_availability_zone

  instance_type = var.master_instance_type
  key_name      = var.key_name
  tags = {
    Name = "k8s-${var.environment}-master"
  }

  vpc_security_group_ids = var.vpc_security_group_ids

  user_data = file(var.master_init_script_path)
}
