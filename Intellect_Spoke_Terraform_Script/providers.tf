# This is needed for modules that don't use aliased providers
provider "azurerm" {
  features {}
  subscription_id = var.spoke_subscription_id
  tenant_id       = var.tenant_id
}