# Data sources in spoke subscription
data "azurerm_virtual_network" "existing_vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "existing_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_key_vault" "kv" {
  name                = "KV-${upper(var.key_vault_name)}"
  resource_group_name = var.resource_group_name 
}

# Data source in hub subscription
data "azurerm_private_dns_zone" "psql_pvt_dns" {
  name                ="privatelink.postgres.database.azure.com"
  resource_group_name = var.hub_resource_group_name
}

resource "random_password" "pass" {
  length      = 14
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 0
  special     = false
}

# Main resources in spoke subscription
resource "azurerm_postgresql_flexible_server" "psql" {
  name                   = "psql${lower(var.postgresql_flexible_server_name)}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.psql_version
  administrator_login    = var.administrator_login
  administrator_password = random_password.pass.result
  zone                   = var.zone
  storage_mb             = var.storage_mb
  storage_tier           = var.storage_tier
  sku_name               = var.sku_name
  auto_grow_enabled      = var.auto_grow_enabled
  tags                   = var.tags
}

# DNS link in hub subscription
resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  name                  = "link-${data.azurerm_virtual_network.existing_vnet.name}-psql"
  private_dns_zone_name = data.azurerm_private_dns_zone.psql_pvt_dns.name
  virtual_network_id    = data.azurerm_virtual_network.existing_vnet.id
  resource_group_name   = data.azurerm_private_dns_zone.psql_pvt_dns.resource_group_name
  tags                  = var.tags
  depends_on = [ azurerm_postgresql_flexible_server.psql ]
}

# Private endpoint in spoke subscription
resource "azurerm_private_endpoint" "psql_pvt_enpoint" {
  name                = "pe-${azurerm_postgresql_flexible_server.psql.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.existing_subnet.id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-${azurerm_postgresql_flexible_server.psql.name}"
    private_connection_resource_id = azurerm_postgresql_flexible_server.psql.id
    is_manual_connection           = false
    subresource_names              = ["postgresqlServer"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.psql_pvt_dns.name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.psql_pvt_dns.id]
  }
  depends_on = [ azurerm_postgresql_flexible_server.psql ]
}

# Configuration in spoke subscription
# resource "azurerm_postgresql_flexible_server_configuration" "psql_configuration" {
#   name      = "azure.extensions"
#   server_id = azurerm_postgresql_flexible_server.psql.id
#   value     = "VECTOR"
# }

# Key vault secrets in spoke subscription
resource "azurerm_key_vault_secret" "kv_hostname_store" {
  name         = var.kv_database_hostname_name
  value        = "${azurerm_postgresql_flexible_server.psql.name}.${data.azurerm_private_dns_zone.psql_pvt_dns.name}"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "kv_username_store" {
  name         = var.kv_database_username_name
  value        = azurerm_postgresql_flexible_server.psql.administrator_login
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "kv_password_store" {
  name         = var.kv_database_password_name
  value        = azurerm_postgresql_flexible_server.psql.administrator_password
  key_vault_id = data.azurerm_key_vault.kv.id
}