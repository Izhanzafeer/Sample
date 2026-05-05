resource "azurerm_logic_app_workflow" "logic_app" {
  name                = "LA-${upper(var.logic_app_name)}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}