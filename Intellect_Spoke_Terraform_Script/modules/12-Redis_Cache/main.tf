data "azurerm_virtual_network" "existing_vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "existing_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

# Data source in hub subscription
data "azurerm_private_dns_zone" "rd_pvt_dns" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = var.hub_resource_group_name
}


resource "azurerm_redis_cache" "redis" {
  name                          = "REDIS-${upper(var.redis_name)}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  capacity                      = var.capacity
  family                        = var.family
  sku_name                      = var.sku_name
  non_ssl_port_enabled          = var.enable_non_ssl_port
  minimum_tls_version           = var.minimum_tls_version
  tags                          = var.tags
  public_network_access_enabled = var.public_network_access_enabled
  redis_configuration {}
}


# DNS link in hub subscription
resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  name                  = "link-${data.azurerm_virtual_network.existing_vnet.name}-rd"
  private_dns_zone_name = data.azurerm_private_dns_zone.rd_pvt_dns.name
  virtual_network_id    = data.azurerm_virtual_network.existing_vnet.id
  resource_group_name   = data.azurerm_private_dns_zone.rd_pvt_dns.resource_group_name
  tags                  = var.tags
  depends_on            = [azurerm_redis_cache.redis]
}

# Private endpoint in spoke subscription
resource "azurerm_private_endpoint" "psql_pvt_enpoint" {
  name                = "pe-${azurerm_redis_cache.redis.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.existing_subnet.id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-${azurerm_redis_cache.redis.name}"
    private_connection_resource_id = azurerm_redis_cache.redis.id
    is_manual_connection           = false
    subresource_names              = ["redisCache"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.rd_pvt_dns.name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.rd_pvt_dns.id]
  }
  depends_on = [azurerm_redis_cache.redis]
}
