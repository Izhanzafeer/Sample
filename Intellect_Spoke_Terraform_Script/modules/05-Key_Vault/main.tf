data "azurerm_client_config" "current" {}

data "azurerm_virtual_network" "existing_vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.key_vault_rg
}

data "azurerm_subnet" "existing_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.key_vault_rg
}

# Data source in hub subscription
data "azurerm_private_dns_zone" "vault_pvt_dns" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.hub_resource_group_name
}

resource "random_string" "azurerm_key_vault_name" {
  length  = 13
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "random_string" "kvsuffix" {
  length  = 4
  special = false
  upper   = false
}

locals {
  current_user_id = coalesce(var.msi_id, data.azurerm_client_config.current.object_id)
}

resource "azurerm_key_vault" "vault" {
  name                       = "KV-${upper(var.vault_name)}"
  location                   = var.key_vault_location
  resource_group_name        = var.key_vault_rg
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = var.sku_name
  soft_delete_retention_days = 7
  tags                       = var.tags
}

resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  key_vault_id       = azurerm_key_vault.vault.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = local.current_user_id
  key_permissions    = var.key_permissions
  secret_permissions = var.secret_permissions
  depends_on         = [azurerm_key_vault.vault]
}

# DNS link in hub subscription
resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  name                  = "link-${data.azurerm_virtual_network.existing_vnet.name}"
  private_dns_zone_name = data.azurerm_private_dns_zone.vault_pvt_dns.name
  virtual_network_id    = data.azurerm_virtual_network.existing_vnet.id
  resource_group_name   = data.azurerm_private_dns_zone.vault_pvt_dns.resource_group_name
  tags                  = var.tags
  depends_on = [ azurerm_key_vault.vault, azurerm_key_vault_access_policy.key_vault_access_policy ] 
}

# Private endpoint in spoke subscription
resource "azurerm_private_endpoint" "psql_pvt_enpoint" {
  name                = "pe-${azurerm_key_vault.vault.name}"
  location            = var.key_vault_location
  resource_group_name = var.key_vault_rg
  subnet_id           = data.azurerm_subnet.existing_subnet.id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-${azurerm_key_vault.vault.name}"
    private_connection_resource_id = azurerm_key_vault.vault.id
    is_manual_connection           = false
    subresource_names              = ["Vault"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.vault_pvt_dns.name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.vault_pvt_dns.id]
  }
  depends_on = [
    azurerm_key_vault.vault,
    azurerm_key_vault_access_policy.key_vault_access_policy,
    azurerm_private_dns_zone_virtual_network_link.dns_vnet_link
  ]
}
