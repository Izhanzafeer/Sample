// Outputs for Azure Resource Group
output "resource_group_name" {
  description = "Name of the Azure Resource Group"
  value       = var.resource_group_enabled ? module.resource_groups[0].resource_group_name : null
}

output "resource_group_id" {
  description = "ID of the Azure Resource Group"
  value       = var.resource_group_enabled ? module.resource_groups[0].resource_group_id : null
}

output "resource_group_location" {
  description = "Location of the Azure Resource Group"
  value       = var.resource_group_enabled ? module.resource_groups[0].resource_group_location : null
}

output "resource_group_tags" {
  description = "Tags of the Azure Resource Group"
  value       = var.resource_group_enabled ? module.resource_groups[0].resource_group_tags : null
}

// Outputs for Azure Virtual Network
output "virtual_network_name" {
  description = "Name of the Azure Virtual Network"
  value       = var.virtual_network_enabled ? module.virtual_networks[0].virtual_network_name : null
}

output "virtual_network_id" {
  description = "ID of the Azure Virtual Network"
  value       = var.virtual_network_enabled ? module.virtual_networks[0].virtual_network_id : null
}