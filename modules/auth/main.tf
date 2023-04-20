resource "azurerm_ssh_public_key" "ssh-key" {
  name                = "${var.environment}-ssh-key"
  resource_group_name = var.resource_group
  location            = var.location
  public_key          = file(var.ssh_key_filepath)
}