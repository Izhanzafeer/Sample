data "azurerm_log_analytics_workspace" "law" {
  name                = "LAW-${upper(var.log_analytics_workspace_name)}"
  resource_group_name = var.resource_group_name
}


resource "azurerm_application_insights" "app_insight" {
  name                = "INSIGHT-${upper(var.app_insight_name)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = data.azurerm_log_analytics_workspace.law.id
  application_type    = var.application_type
}
