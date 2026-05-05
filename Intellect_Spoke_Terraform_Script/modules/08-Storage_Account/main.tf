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
data "azurerm_private_dns_zone" "st_pvt_dns" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.hub_resource_group_name
}

resource "azurerm_storage_account" "stg" {
  name                          = "stg${lower(replace(var.storage_account_name, "-", ""))}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags
}

# DNS link in hub subscription
resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  name                  = "link-${data.azurerm_virtual_network.existing_vnet.name}-stg"
  private_dns_zone_name = data.azurerm_private_dns_zone.st_pvt_dns.name
  virtual_network_id    = data.azurerm_virtual_network.existing_vnet.id
  resource_group_name   = data.azurerm_private_dns_zone.st_pvt_dns.resource_group_name
  tags                  = var.tags
  depends_on = [ azurerm_storage_account.stg ]
}

# Private endpoint in spoke subscription
resource "azurerm_private_endpoint" "psql_pvt_enpoint" {
  name                = "pe-${azurerm_storage_account.stg.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.existing_subnet.id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-${azurerm_storage_account.stg.name}"
    private_connection_resource_id = azurerm_storage_account.stg.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.st_pvt_dns.name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.st_pvt_dns.id]
  }
}
