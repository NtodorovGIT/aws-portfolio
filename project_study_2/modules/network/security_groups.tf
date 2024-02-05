resource "aws_security_group" "vpc_security_groups" {
  vpc_id   = aws_vpc.server_vpc.id
  for_each =var.security_groups_vpc
}

resource "aws_security_group_rule" "sg_public_rules_ingress" {
  for_each          = var.sg_ingress_rules
  security_group_id = aws_security_group.vpc_security_groups["sg_public"].id
  from_port         = each.value.from_port
  protocol          = each.value.protocol
  to_port           = each.value.to_port
  cidr_blocks       = each.value.cidr_block
  type              = "ingress"
}
resource "aws_security_group_rule" "sg_public_rules_egress" {
  for_each          = var.sg_egress_rules
  security_group_id = aws_security_group.vpc_security_groups["sg_public"].id
  from_port         = each.value.from_port
  protocol          = each.value.protocol
  to_port           = each.value.to_port
  cidr_blocks       = each.value.cidr_block
  type              = "egress"
}

resource "aws_security_group_rule" "sg_private_rules_ingress" {
  for_each          = var.sg_ingress_rules
  security_group_id = aws_security_group.vpc_security_groups["sg_private"].id
  from_port         = each.value.from_port
  protocol          = each.value.protocol
  to_port           = each.value.to_port
  cidr_blocks       = each.value.cidr_block
  type              = "ingress"
}
resource "aws_security_group_rule" "sg_private_rules_egress" {
  for_each          = var.sg_egress_rules
  security_group_id = aws_security_group.vpc_security_groups["sg_private"].id
  from_port         = each.value.from_port
  protocol          = each.value.protocol
  to_port           = each.value.to_port
  cidr_blocks       = each.value.cidr_block
  type              = "egress"
}