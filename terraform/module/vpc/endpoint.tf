resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  tags = {
    Name = "${var.account_name}-${var.environment}-s3-endpoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "s3" {
  count           = length(aws_route_table.private)
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = aws_route_table.private[count.index].id
}

resource "aws_vpc_endpoint_policy" "s3_endpoint_policy" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*",
        Action    = ["s3:GetObject"],
        Resource  = "arn:aws:s3:::al2023-repos-ap-northeast-2-de612dc2/*"
      }
    ]
  })
}
