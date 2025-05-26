resource "aws_instance" "bastion" {
  ami                         = var.bastion_ami
  subnet_id                   = aws_subnet.public[0].id
  associate_public_ip_address = true
  availability_zone           = var.bastion_availability_zone

  instance_type = var.bastion_instance_type
  key_name      = var.bastion_key_name
  tags = {
    Name = "bastion-${var.environment}"
  }

  vpc_security_group_ids = [aws_security_group.home.id]
}
