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
