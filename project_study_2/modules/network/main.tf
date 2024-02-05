resource "aws_vpc" "server_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "vpc_case_study_2"
  }
}

resource "aws_subnet" "vpc_subnet" {
  for_each = var.vpc_subnets
  vpc_id                  = aws_vpc.server_vpc.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = each.value.map_public_ip_on_lunch
  availability_zone       = each.value.availability_zone

  tags = {
    Name = each.value.tag
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.server_vpc.id

  tags = {
    Name = "ig_case2"
  }
}

resource "aws_route_table" "rt_vpc" {
  for_each = var.route_tables_vpc
  vpc_id   = aws_vpc.server_vpc.id

  tags = {
    name = each.value.tag
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.rt_vpc["route_table1"].id
  destination_cidr_block = var.rt_cidr_block
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_rt_asso" {
  subnet_id      = aws_subnet.vpc_subnet["public1"].id
  route_table_id = aws_route_table.rt_vpc["route_table1"].id
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.rt_vpc["route_table2"].id
  destination_cidr_block = var.rt_cidr_block
  gateway_id             = aws_nat_gateway.public_nat_gw.id
}

resource "aws_route_table_association" "private_rt_asso" {
  subnet_id      = aws_subnet.vpc_subnet["private"].id
  route_table_id = aws_route_table.rt_vpc["route_table2"].id
}

resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "public_nat_gw" {
  allocation_id     = aws_eip.nat_eip.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.vpc_subnet["public1"].id

  tags = {
    Name = "NAT_gw_case2"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_network_acl" "vpc_nacl" {
  vpc_id     = aws_vpc.server_vpc.id
}

resource "aws_network_acl_rule" "nacl_rules" {
  for_each       = var.nacl_rules
  network_acl_id = aws_network_acl.vpc_nacl.id
  protocol       = each.value.protocol
  rule_action    = each.value.action
  rule_number    = each.value.rule_no
  from_port      = each.value.from_port
  to_port        = each.value.to_port
  cidr_block     = each.value.cidr_block
}