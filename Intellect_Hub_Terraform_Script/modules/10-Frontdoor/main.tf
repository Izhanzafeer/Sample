resource "azurerm_cdn_frontdoor_profile" "frontdoor" {
  name                = upper("fd-${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}")
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
}
