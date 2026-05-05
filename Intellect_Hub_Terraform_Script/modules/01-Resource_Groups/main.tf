resource "azurerm_resource_group" "azurerm_resource_group" {
  name     = upper("rg-${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}")
  location = var.location
  tags     = var.tags
}
