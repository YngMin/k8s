resource "aws_route_table" "private" {
  count = length(aws_subnet.private)

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  route {
    cidr_block = "10.${var.cidr_numeral}.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "${var.account_name}-${var.environment}-private-${count.index}"
  }
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_nat_gateway" "main" {
  count = length(aws_subnet.private)

  allocation_id = aws_eip.nat.*.id[count.index]
  subnet_id     = aws_subnet.public.*.id[count.index]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.account_name}-${var.environment}-${count.index}}"
  }
}

resource "aws_eip" "nat" {
  count  = length(aws_subnet.private)
  domain = "vpc"

  lifecycle {
    create_before_destroy = true
  }
}
