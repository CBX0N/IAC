resource "azurerm_network_security_group" "nsg" {
  name                = "${var.environment}-nsg"
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = var.internal_subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
