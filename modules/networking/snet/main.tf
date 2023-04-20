resource "azurerm_subnet" "internal-subnet" {
  name                 = "${var.environment}-internal-snet"
  resource_group_name  = var.resource_group
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.subnet_external_address_range]
}

resource "azurerm_subnet" "external-subnet" {
  name                 = "${var.environment}-external-snet"
  resource_group_name  = var.resource_group
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.subnet_internal_address_range]
}