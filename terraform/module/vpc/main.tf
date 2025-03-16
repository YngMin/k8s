resource "aws_vpc" "main" {
  cidr_block           = "10.${var.cidr_numeral}.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.account_name}-${var.environment}"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
