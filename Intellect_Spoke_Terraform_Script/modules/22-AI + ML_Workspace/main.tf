data "azurerm_application_insights" "appinsights" {
  name                = "INSIGHT-${upper(var.app_insight_name)}"
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "kv" {
  name                = "KV-${upper(var.vault_name)}"
  resource_group_name = var.resource_group_name
}


data "azurerm_storage_account" "stg" {
  name                = "stg${lower(var.storage_account_name)}"
  resource_group_name = var.resource_group_name
}


resource "azurerm_machine_learning_workspace" "example" {
  name                    = "ML-${upper(var.ml_name)}"
  location                = var.location
  resource_group_name     = var.resource_group_name
  application_insights_id = data.azurerm_application_insights.appinsights.id
  key_vault_id            = data.azurerm_key_vault.kv.id
  storage_account_id      = data.azurerm_storage_account.stg.id
  tags                    = var.tags

  identity {
    type = "SystemAssigned"
  }
}
