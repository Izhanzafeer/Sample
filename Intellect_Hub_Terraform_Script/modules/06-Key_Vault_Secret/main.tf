# data "azurerm_key_vault" "vault" {
#   name                = var.vault_name
#   resource_group_name = var.key_vault_rg
# }


resource "azurerm_key_vault_secret" "secret" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = var.key_vault_id
}  