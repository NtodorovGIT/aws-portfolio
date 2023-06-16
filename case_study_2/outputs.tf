output "public_subnet_ids" {
  value = module.network.subnet_id[1]
}
output "sg_public_id" {
  value = module.network.security_group_id[0]
}

output "vpc_id" {
  value = module.network.vpc_id
}