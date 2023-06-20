## Summary

This README is about deploying a network module.

## Usage

The `module block` should look like this:

```hcl
module "network"{
 
 source = "./modules/network"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.public_nat_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_acl.vpc_nacl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl_rule.nacl_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_route.private_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.rt_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_rt_asso](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_rt_asso](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.vpc_security_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.sg_private_rules_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_private_rules_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_public_rules_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_public_rules_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_subnet.vpc_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.server_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_nacl_rules"></a> [nacl\_rules](#input\_nacl\_rules) | n/a | <pre>map(object({<br>    action     = string<br>    from_port  = number<br>    to_port    = number<br>    protocol   = string<br>    rule_no    = number<br>    cidr_block = string<br>  }))</pre> | <pre>{<br>  "egress": {<br>    "action": "allow",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_no": 100,<br>    "to_port": 0<br>  },<br>  "ingress": {<br>    "action": "allow",<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "rule_no": 100,<br>    "to_port": 0<br>  }<br>}</pre> | no |
| <a name="input_route_tables_vpc"></a> [route\_tables\_vpc](#input\_route\_tables\_vpc) | n/a | <pre>map(object({<br>    cidr_block = string<br>    tag        = string<br>  }))</pre> | <pre>{<br>  "route_table1": {<br>    "cidr_block": "0.0.0.0/0",<br>    "tag": "public_rt_case2"<br>  },<br>  "route_table2": {<br>    "cidr_block": "0.0.0.0/0",<br>    "tag": "private_rt_case2"<br>  }<br>}</pre> | no |
| <a name="input_rt_cidr_block"></a> [rt\_cidr\_block](#input\_rt\_cidr\_block) | n/a | `string` | `"0.0.0.0/0"` | no |
| <a name="input_security_groups_vpc"></a> [security\_groups\_vpc](#input\_security\_groups\_vpc) | n/a | <pre>map(object({<br>    name = string<br>  }))</pre> | <pre>{<br>  "sg_private": {<br>    "name": "security_group_private"<br>  },<br>  "sg_public": {<br>    "name": "security_group_public"<br>  }<br>}</pre> | no |
| <a name="input_sg_egress_rules"></a> [sg\_egress\_rules](#input\_sg\_egress\_rules) | n/a | <pre>map(object({<br>    description = string<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_block  = list(string)<br>  }))</pre> | <pre>{<br>  "egress": {<br>    "cidr_block": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "internet_access",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "to_port": 0<br>  }<br>}</pre> | no |
| <a name="input_sg_ingress_rules"></a> [sg\_ingress\_rules](#input\_sg\_ingress\_rules) | n/a | <pre>map(object({<br>    description = string<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_block  = list(string)<br>  }))</pre> | <pre>{<br>  "ingres2": {<br>    "cidr_block": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "http_connection",<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "to_port": 80<br>  },<br>  "ingress1": {<br>    "cidr_block": [<br>      "79.100.82.171/32"<br>    ],<br>    "description": "ssh_connection",<br>    "from_port": 22,<br>    "protocol": "tcp",<br>    "to_port": 22<br>  }<br>}</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_nacl"></a> [vpc\_nacl](#input\_vpc\_nacl) | n/a | <pre>map(object({<br>    name = string<br>  }))</pre> | <pre>{<br>  "private_nacl": {<br>    "name": "private_nacl"<br>  },<br>  "public_nacl": {<br>    "name": "public_nacl"<br>  }<br>}</pre> | no |
| <a name="input_vpc_subnets"></a> [vpc\_subnets](#input\_vpc\_subnets) | n/a | <pre>map(object({<br>    cidr_block             = string<br>    map_public_ip_on_lunch = bool<br>    availability_zone      = string<br>    tag                    = string<br>  }))</pre> | <pre>{<br>  "private": {<br>    "availability_zone": "eu-south-1b",<br>    "cidr_block": "10.0.11.0/24",<br>    "map_public_ip_on_lunch": false,<br>    "tag": "private_sb"<br>  },<br>  "public1": {<br>    "availability_zone": "eu-south-1a",<br>    "cidr_block": "10.0.9.0/24",<br>    "map_public_ip_on_lunch": true,<br>    "tag": "public_sb_bastion"<br>  },<br>  "public2": {<br>    "availability_zone": "eu-south-1b",<br>    "cidr_block": "10.0.10.0/24",<br>    "map_public_ip_on_lunch": true,<br>    "tag": "public_sb_alb"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_gw_vpc"></a> [nat\_gw\_vpc](#output\_nat\_gw\_vpc) | n/a |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | n/a |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_TF_DOCS -->