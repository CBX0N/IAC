resource "azurerm_network_security_group" "nsg" {
  name                = "${var.environment}-nsg"
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_virtual_network" "network_gateway" {
  name                = "${var.environment}-gw"
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = var.address_space
  tags = {
    "environment" = "${var.environment}"
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.environment}-snet"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.network_gateway.name
  address_prefixes     = [var.subnet_address_range]
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface" "vnic" {
  name                = "${var.environment}-vnic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "dynamicIP"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
