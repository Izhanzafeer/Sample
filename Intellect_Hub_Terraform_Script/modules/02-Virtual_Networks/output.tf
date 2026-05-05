// Output for the Virtual Network Name
output "virtual_network_name" {
  description = "Name of the Azure Virtual Network"
  value       = azurerm_virtual_network.azurerm_virtual_network.name
}

// Output for the Virtual Network ID
output "virtual_network_id" {
  description = "ID of the Azure Virtual Network"
  value       = azurerm_virtual_network.azurerm_virtual_network.id
}

// Output for the Virtual Network Location
output "virtual_network_location" {
  description = "Location of the Azure Virtual Network"
  value       = azurerm_virtual_network.azurerm_virtual_network.location
}

// Output for the Virtual Network Tags
output "virtual_network_tags" {
  description = "Tags of the Azure Virtual Network"
  value       = azurerm_virtual_network.azurerm_virtual_network.tags
}