terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.52.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id       = var.service_principal.client_id
  client_secret   = var.service_principal.client_secret
  tenant_id       = var.service_principal.tenant_id
  subscription_id = var.service_principal.subscription_id
}