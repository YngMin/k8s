output "vpc_id" {
  value = aws_vpc.main.id
}

output "main_security_group_id" {
  value = aws_security_group.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}

output "private_db_subnet_ids" {
  value = aws_subnet.private_db.*.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}
