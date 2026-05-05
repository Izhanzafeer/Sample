data "azurerm_virtual_network" "existing_vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone" "psql_pvt_dns" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "psql_vnet_link" {
  name                  = "link-${var.virtual_network_name}-psql"
  private_dns_zone_name = azurerm_private_dns_zone.psql_pvt_dns.name
  virtual_network_id    = data.azurerm_virtual_network.existing_vnet.id
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
  depends_on            = [azurerm_private_dns_zone.psql_pvt_dns]
}

resource "azurerm_private_dns_zone" "stg" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "stg_vnet_link" {
  name                  = "link-${var.virtual_network_name}-stg"
  private_dns_zone_name = azurerm_private_dns_zone.stg.name
  virtual_network_id    = data.azurerm_virtual_network.existing_vnet.id
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
  depends_on            = [azurerm_private_dns_zone.stg]
}

resource "azurerm_private_dns_zone" "acr" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr_vnet_link" {
  name                  = "link-${var.virtual_network_name}-acr"
  private_dns_zone_name = azurerm_private_dns_zone.acr.name
  virtual_network_id    = data.azurerm_virtual_network.existing_vnet.id
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
  depends_on            = [azurerm_private_dns_zone.acr]
}

resource "azurerm_private_dns_zone" "key_vault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "kv_vnet_link" {
  name                  = "link-${var.virtual_network_name}-kv"
  private_dns_zone_name = azurerm_private_dns_zone.key_vault.name
  virtual_network_id    = data.azurerm_virtual_network.existing_vnet.id
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
  depends_on            = [azurerm_private_dns_zone.key_vault]
}

resource "azurerm_private_dns_zone" "func_app" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "func_app_vnet_link" {
  name                  = "link-${var.virtual_network_name}-func_app"
  private_dns_zone_name = azurerm_private_dns_zone.func_app.name
  virtual_network_id    = data.azurerm_virtual_network.existing_vnet.id
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
  depends_on            = [azurerm_private_dns_zone.func_app]
}

resource "azurerm_private_dns_zone" "redis" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis_vnet_link" {
  name                  = "link-${var.virtual_network_name}-redis"
  private_dns_zone_name = azurerm_private_dns_zone.redis.name
  virtual_network_id    = data.azurerm_virtual_network.existing_vnet.id
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
  depends_on            = [azurerm_private_dns_zone.redis]
}

resource "azurerm_private_dns_zone" "sb" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "sb_vnet_link" {
  name                  = "link-${var.virtual_network_name}-sb"
  private_dns_zone_name = azurerm_private_dns_zone.sb.name
  virtual_network_id    = data.azurerm_virtual_network.existing_vnet.id
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
  depends_on            = [azurerm_private_dns_zone.sb]
}