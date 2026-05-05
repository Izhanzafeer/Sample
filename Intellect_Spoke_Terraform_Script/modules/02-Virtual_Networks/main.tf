resource "azurerm_virtual_network" "vnet" {
  name                = "VNET-${upper(var.virtual_network_name)}"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [var.vnet_address_space]
  tags                = var.tags
}
