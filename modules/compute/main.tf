resource "azurerm_network_interface" "vnic" {
  name                = "${var.vm_name}-vnic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "dynamicIP"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                             = var.vm_name
  location                         = var.location
  resource_group_name              = var.resource_group
  network_interface_ids            = [azurerm_network_interface.vnic.id]
  vm_size                          = "Standard_DS1_v2"
  delete_data_disks_on_termination = true
  delete_os_disk_on_termination    = true
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm_name}-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"

  }

  os_profile {
    admin_username = var.username
    computer_name  = var.vm_name
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = var.ssh_key_data
      path     = "/home/${var.username}/.ssh/authorized_keys"
    }
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_internal_backend_association" {
  backend_address_pool_id = var.internal_backend_id
  ip_configuration_name   = "dynamicIP"
  network_interface_id    = azurerm_network_interface.vnic.id
}