resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.environment}-vm"
  location              = var.location
  resource_group_name   = var.resource_group
  network_interface_ids = [var.vnic]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.environment}-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    admin_username = var.username
    computer_name = "${var.environment}-vm"
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = var.ssh_key_data
      path = "/home/${var.username}/.ssh/authorized_keys"
    }
  }
}