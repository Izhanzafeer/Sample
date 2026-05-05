data "azurerm_client_config" "current" {}

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
  name                       = upper("vnet-${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}")
  location                   = var.location
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
