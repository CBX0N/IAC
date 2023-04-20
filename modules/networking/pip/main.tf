resource "azurerm_public_ip" "pip" {
  allocation_method   = "Static"
  sku                 = "Standard"
  name                = var.pip_name
  location            = var.location
  resource_group_name = var.resource_group
}