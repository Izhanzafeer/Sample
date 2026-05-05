resource "azurerm_service_plan" "app_service_plan" {
  name                = "ASP-${upper(var.app_service_plan_name)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.app_service_os_type
  sku_name            = var.app_service_sku_name
  tags                = var.tags
}
