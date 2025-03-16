resource "aws_route_table" "private_db" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "10.${var.cidr_numeral}.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "${var.account_name}-${var.environment}-private-db"
  }
}

resource "aws_route_table_association" "private_db" {
  count = length(aws_subnet.private_db)

  subnet_id      = aws_subnet.private_db[count.index].id
  route_table_id = aws_route_table.private_db.id
}
