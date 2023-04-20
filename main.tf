resource "azurerm_resource_group" "resource_group" {
  name     = "${var.environment}-rg"
  location = var.location

  tags = {
    "environment" = "${var.environment}"
  }
}

module "networking" {
  source               = "./modules/networking"
  location             = azurerm_resource_group.resource_group.location
  environment          = var.environment
  resource_group       = azurerm_resource_group.resource_group.name
  address_space        = [var.address_space]
  subnet_address_range = "10.0.1.0/24"

}

module "auth" {
  source           = "./modules/auth"
  location         = azurerm_resource_group.resource_group.location
  environment      = var.environment
  resource_group   = azurerm_resource_group.resource_group.name
  ssh_key_filepath = var.ssh_key_filepath

}

module "compute" {
  source         = "./modules/compute"
  location       = azurerm_resource_group.resource_group.location
  environment    = var.environment
  resource_group = azurerm_resource_group.resource_group.name
  ssh_key_data       = module.auth.ssh_key_data
  username = "azureuser"
  vnic           = module.networking.vnic
}