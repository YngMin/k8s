resource "aws_instance" "worker" {
  count = var.worker_count

  ami                         = var.ami
  subnet_id                   = var.private_subnet_ids[count.index]
  associate_public_ip_address = true
  availability_zone           = var.worker_availability_zones[count.index]

  instance_type = var.worker_instance_type
  key_name      = var.key_name
  tags = {
    Name = "k8s-${var.environment}-worker-${count.index}"
  }

  vpc_security_group_ids = var.vpc_security_group_ids

  user_data = templatefile(var.worker_init_script_path, {
    hostname = "worker-${count.index}"
  })
}
