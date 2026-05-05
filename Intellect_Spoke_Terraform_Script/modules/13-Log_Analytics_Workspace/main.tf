resource "azurerm_log_analytics_workspace" "law" {
  name                = "LAW-${upper(var.log_analytics_workspace_name)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.law_sku
  retention_in_days   = var.retention_in_days
}