// Output for the Resource Group Name
output "resource_group_name" {
  description = "Name of the Azure Resource Group"
  value       = azurerm_resource_group.azurerm_resource_group.name
}

// Output for the Resource Group ID
output "resource_group_id" {
  description = "ID of the Azure Resource Group"
  value       = azurerm_resource_group.azurerm_resource_group.id
}

// Output for the Resource Group Location
output "resource_group_location" {
  description = "Location of the Azure Resource Group"
  value       = azurerm_resource_group.azurerm_resource_group.location
}

// Output for the Resource Group Tags
output "resource_group_tags" {
  description = "Tags of the Azure Resource Group"
  value       = azurerm_resource_group.azurerm_resource_group.tags
}