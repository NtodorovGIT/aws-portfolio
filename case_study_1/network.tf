resource "aws_vpc" "server_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "case-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.server_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-south-1a"
  tags = {
    Name = "public_subnet_bastion"
  }
}

resource "aws_subnet" "public_subnet_alb" {
  vpc_id                  = aws_vpc.server_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-south-1b"
  tags = {
    Name = "public_subnet_alb"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.server_vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "eu-south-1b"
  tags = {
    Name = "private_subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.server_vpc.id
  tags = {
    Name = "ig_case_vpc"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.server_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "public_rt_asso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.server_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat_gw.id
  }
  tags = {
    Name = "private_rt"
  }
}

resource "aws_route_table_association" "private_rt_asso" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "public_nat_gw" {
  allocation_id     = aws_eip.nat_eip.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public_subnet.id
  tags = {
    Name = "NAT_gw"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_network_acl" "public_acl" {
  vpc_id = aws_vpc.server_vpc.id
  egress {
    action     = "allow"
    from_port  = 0
    protocol   = "-1"
    rule_no    = 100
    to_port    = 0
    cidr_block = "0.0.0.0/0"

  }
  ingress {
    action     = "allow"
    from_port  = 0
    protocol   = "-1"
    rule_no    = 100
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_network_acl" "private_acl" {
  vpc_id = aws_vpc.server_vpc.id
  egress {
    action     = "allow"
    from_port  = 0
    protocol   = "-1"
    rule_no    = 100
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }
  ingress {
    action     = "allow"
    from_port  = 0
    protocol   = "-1"
    rule_no    = 100
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }
}