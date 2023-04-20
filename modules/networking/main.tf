module "vnet" {
  source         = "./vnet"
  address_space  = var.address_space
  environment    = var.environment
  location       = var.location
  resource_group = var.resource_group
}

module "snet" {
  source                        = "./snet"
  subnet_internal_address_range = var.subnet_internal_address_range
  subnet_external_address_range = var.subnet_external_address_range
  environment                   = var.environment
  resource_group                = var.resource_group
  vnet_name                     = var.vnet_name
}

module "nsg" {
  source             = "./nsg"
  internal_subnet_id = module.snet.internal_subnet_id
  location           = var.location
  environment        = var.environment
  resource_group     = var.resource_group
}

module "pip" {
  source         = "./pip"
  location       = var.location
  resource_group = var.resource_group
  pip_name       = var.pip_name
}

module "lb" {
  source         = "./lb"
  location       = var.location
  resource_group = var.resource_group
  lb_name        = var.lb_name
  public_ip_id   = module.pip.public_ip_id
  vnet_id        = module.vnet.vnet_id
}