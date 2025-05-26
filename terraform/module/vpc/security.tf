resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  ip_protocol       = "tcp"
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 22
  security_group_id = aws_security_group.main.id
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "api_server" {
  ip_protocol       = "tcp"
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 6443
  security_group_id = aws_security_group.main.id
  to_port           = 6443
}

resource "aws_vpc_security_group_ingress_rule" "etcd" {
  ip_protocol       = "tcp"
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 2379
  security_group_id = aws_security_group.main.id
  to_port           = 2380
}


resource "aws_vpc_security_group_ingress_rule" "kubelet" {
  ip_protocol       = "tcp"
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 10250
  security_group_id = aws_security_group.main.id
  to_port           = 10255
}

resource "aws_vpc_security_group_ingress_rule" "node_port" {
  ip_protocol       = "tcp"
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 30000
  security_group_id = aws_security_group.main.id
  to_port           = 32767
}

resource "aws_vpc_security_group_egress_rule" "default" {
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = -1
  security_group_id = aws_security_group.main.id
  to_port           = -1
}

resource "aws_security_group" "home" {
  vpc_id = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "home" {
  ip_protocol = "tcp"
  # cidr_ipv4         = var.home_ip
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  security_group_id = aws_security_group.home.id
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "home" {
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = -1
  security_group_id = aws_security_group.home.id
  to_port           = -1
}
