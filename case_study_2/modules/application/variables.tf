variable "vpc_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "private_sg_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "public_alb_subnet_id" {
  type = string
}

variable "public_sg_id" {
  type = string
}

variable "nat_gw_vpc" {
  type = string
}