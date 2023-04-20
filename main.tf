resource "azurerm_resource_group" "resource_group" {
  name     = "${var.environment}-rg"
  location = var.location

  tags = {
    "environment" = "${var.environment}"
  }
}

module "networking" {
  source                        = "./modules/networking"
  location                      = azurerm_resource_group.resource_group.location
  environment                   = var.environment
  resource_group                = azurerm_resource_group.resource_group.name
  address_space                 = var.address_space
  vnet_name                     = var.vnet_name
  subnet_external_address_range = var.subnet_external_address_range
  subnet_internal_address_range = var.subnet_internal_address_range
  pip_name                      = var.pip_name
  lb_name                       = var.lb_name
}

module "auth" {
  source           = "./modules/auth"
  location         = azurerm_resource_group.resource_group.location
  environment      = var.environment
  resource_group   = azurerm_resource_group.resource_group.name
  ssh_key_filepath = var.ssh_key_filepath
}

module "compute" {
  for_each            = var.vm_name
  source              = "./modules/compute"
  location            = azurerm_resource_group.resource_group.location
  environment         = var.environment
  resource_group      = azurerm_resource_group.resource_group.name
  ssh_key_data        = module.auth.ssh_key_data
  username            = "azureuser"
  vm_name             = each.value
  subnet_id           = module.networking.internal_subnet_id
  lb_id               = module.networking.lb_id
  internal_backend_id = module.networking.internal_backend_id
  vnet_id             = module.networking.vnet_id
}