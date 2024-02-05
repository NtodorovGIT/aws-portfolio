output "subnet_id" {
  value = [for k, v in aws_subnet.vpc_subnet : aws_subnet.vpc_subnet[k].id]
}

output "security_group_id" {
  value = [for k, v in aws_security_group.vpc_security_groups : aws_security_group.vpc_security_groups[k].id]
}

output "vpc_id" {
  value = aws_vpc.server_vpc.id
}

output "nat_gw_vpc" {
  value = aws_nat_gateway.public_nat_gw.id
}