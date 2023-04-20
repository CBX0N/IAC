resource "azurerm_lb" "external_lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "PublicIP"
    public_ip_address_id = var.public_ip_id
  }

}

resource "azurerm_lb_backend_address_pool" "internal_backend" {
  loadbalancer_id    = azurerm_lb.external_lb.id
  name               = "internal_backend"
}

resource "azurerm_lb_nat_rule" "inbound_ssh" {
    backend_port = "22"
    frontend_port_start = "22"
    frontend_port_end = "23"
    frontend_ip_configuration_name = "PublicIP"
    loadbalancer_id = azurerm_lb.external_lb.id
    name = "ssh-inbound"
    protocol = "Tcp"
    resource_group_name = var.resource_group
    backend_address_pool_id = azurerm_lb_backend_address_pool.internal_backend.id

  
}