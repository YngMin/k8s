resource "aws_subnet" "public" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.${var.cidr_numeral}.${var.cidr_numeral_public[count.index]}.0/22"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.account_name}-${var.environment}-public-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.${var.cidr_numeral}.${var.cidr_numeral_private[count.index]}.0/20"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.account_name}-${var.environment}-private-${count.index}"
  }
}

resource "aws_subnet" "private_db" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.${var.cidr_numeral}.${var.cidr_numeral_private_db[count.index]}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.account_name}-${var.environment}-private-db-${count.index}"
  }
}
