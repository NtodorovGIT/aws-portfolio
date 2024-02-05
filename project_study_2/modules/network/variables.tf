variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_subnets" {
  type = map(object({
    cidr_block             = string
    map_public_ip_on_lunch = bool
    availability_zone      = string
    tag                    = string
  }))
  default = {
    public1 = {
      cidr_block             = "10.0.9.0/24"
      map_public_ip_on_lunch = true
      availability_zone      = "eu-south-1a"
      tag                    = "public_sb_bastion"
    }
    public2 = {
      cidr_block             = "10.0.10.0/24"
      map_public_ip_on_lunch = true
      availability_zone      = "eu-south-1b"
      tag                    = "public_sb_alb"
    }
    private = {
      cidr_block             = "10.0.11.0/24"
      map_public_ip_on_lunch = false
      availability_zone      = "eu-south-1b"
      tag                    = "private_sb"
    }
  }
}

variable "route_tables_vpc" {
  type = map(object({
    cidr_block = string
    tag        = string
  }))
  default = {
    route_table1 = {
      cidr_block = "0.0.0.0/0"
      tag        = "public_rt_case2"
    }
    route_table2 = {
      cidr_block = "0.0.0.0/0"
      tag        = "private_rt_case2"
    }
  }
}

variable "vpc_nacl" {
  type = map(object({
    name = string
  }))
  default = {
    public_nacl ={
      name = "public_nacl"
    }
    private_nacl = {
      name = "private_nacl"
    }
  }
}

variable "nacl_rules" {
  type = map(object({
    action     = string
    from_port  = number
    to_port    = number
    protocol   = string
    rule_no    = number
    cidr_block = string
  }))

  default = {
      ingress = {
        action     = "allow"
        from_port  = 0
        to_port    = 0
        protocol   = "-1"
        rule_no    = 100
        cidr_block = "0.0.0.0/0"
      }
      egress = {
        action     = "allow"
        from_port  = 0
        to_port    = 0
        protocol   = "-1"
        rule_no    = 100
        cidr_block = "0.0.0.0/0"
      }
    }
  }

variable "security_groups_vpc" {
  type = map(object({
    name = string
  }))
  default = {
    sg_public = {
      name = "security_group_public"
    }
    sg_private = {
      name = "security_group_private"
    }
  }
}

variable "sg_ingress_rules" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = list(string)
  }))
  default = {
    ingress1 = {
      description = "ssh_connection"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = ["79.100.82.171/32"]
    }
    ingres2 = {
      description = "http_connection"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = ["0.0.0.0/0"]
    }
  }
}
variable "sg_egress_rules" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = list(string)
  }))
  default = {
    egress = {
      description = "internet_access"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = ["0.0.0.0/0"]
    }
  }
}

variable "rt_cidr_block" {
  type = string
  default = "0.0.0.0/0"
}