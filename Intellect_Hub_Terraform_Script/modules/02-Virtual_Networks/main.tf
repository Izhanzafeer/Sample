resource "azurerm_virtual_network" "azurerm_virtual_network" {
  name                = upper("vnet-${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}")
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}