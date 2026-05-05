data "azurerm_key_vault" "kv" {
  name                = "KV-${upper(var.vault_name)}"
  resource_group_name = var.resource_group_name
}


data "azurerm_storage_account" "stg" {
  name                = "stg${lower(var.storage_account_name)}"
  resource_group_name = var.resource_group_name
}


# Create Azure AI Foundry service
resource "azurerm_ai_foundry" "aif" {
  name                = "AI-${lower(var.ai_foundry_name)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  storage_account_id  = data.azurerm_storage_account.stg.id
  key_vault_id        = data.azurerm_key_vault.kv.id
  tags                = var.tags

  identity {
    type = "SystemAssigned" # Enable system-assigned managed identity
  }
}

