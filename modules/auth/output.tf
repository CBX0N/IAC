output "ssh_key_data" {
  value = azurerm_ssh_public_key.ssh-key.public_key
}