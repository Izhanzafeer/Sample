data "azurerm_client_config" "current" {}


# data "azurerm_key_vault" "kv" {
#   name                = var.vault_name
#   resource_group_name = var.resource_group_name
# }


resource "azurerm_user_assigned_identity" "mi" {
  name                =  upper("fd-${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}")
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}


resource "azurerm_key_vault_access_policy" "policy" {
  key_vault_id            = var.key_vault_id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = azurerm_user_assigned_identity.mi.principal_id
  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  certificate_permissions = var.certificate_permissions
  depends_on = [ azurerm_user_assigned_identity.mi ]
}
