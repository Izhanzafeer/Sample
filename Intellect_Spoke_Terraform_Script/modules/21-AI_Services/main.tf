# Deploy Azure AI Services resource

resource "azurerm_ai_services" "ai" {
  name                = "AIS-${upper(var.ai_service_name)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.ai_service_sku
  tags                = var.tags
}
