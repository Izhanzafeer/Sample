data "azurerm_virtual_network" "spoke" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

data "azurerm_virtual_network" "hub" {
  name                = var.hub_virtual_network_name
  resource_group_name = var.hub_resource_group_name
}

resource "azurerm_virtual_network_peering" "spoke-to-hub" {
  name                         = "spoke-to-hub"
  resource_group_name          = data.azurerm_virtual_network.spoke.resource_group_name
  virtual_network_name         = data.azurerm_virtual_network.spoke.name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub.id 
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
}

resource "azurerm_virtual_network_peering" "hub-to-spoke" {
  name                         = "hub-to-spoke"
  resource_group_name          = data.azurerm_virtual_network.hub.resource_group_name
  virtual_network_name         = data.azurerm_virtual_network.hub.name
  remote_virtual_network_id    = data.azurerm_virtual_network.spoke.id 
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = false
}