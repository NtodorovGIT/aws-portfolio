module "network" {
  source = "./modules/network"
}

module "application" {
  source               = "./modules/application"
  vpc_id               = module.network.vpc_id
  nat_gw_vpc           = module.network.nat_gw_vpc
  private_sg_id        = module.network.security_group_id[1]
  public_sg_id         = module.network.security_group_id[0]
  private_subnet_id    = module.network.subnet_id[0]
  public_subnet_id     = module.network.subnet_id[1]
  public_alb_subnet_id = module.network.subnet_id[0]
}
