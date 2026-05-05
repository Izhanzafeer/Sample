module "resource_groups" {
  source                  = "./modules/01-Resource_Groups"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.location
  tags                    = var.tags
}

module "virtual_networks" {
  source               = "./modules/02-Virtual_Networks"
  virtual_network_name = var.resource_group_name
  resource_group_name  = module.resource_groups.rg_name_out
  location             = module.resource_groups.rg_location_out
  vnet_address_space   = var.vnet_address_space
  tags                 = var.tags
  depends_on           = [module.resource_groups]
}

module "key_vault" {
  source                  = "./modules/05-Key_Vault"
  for_each                = var.key_vault
  vault_name              = each.value.vault_name
  key_vault_rg            = module.resource_groups.rg_name_out
  key_vault_location      = module.resource_groups.rg_location_out
  sku_name                = each.value.sku
  key_permissions         = each.value.key_permissions
  secret_permissions      = each.value.secret_permissions
  certificate_permissions = each.value.certificate_permissions
  virtual_network_name    = module.virtual_networks.vnet_name_out
  subnet_name             = module.data_subnet.data_snet_name_out
  hub_resource_group_name = var.hub_resource_group_name
  tags                    = var.tags
  depends_on              = [module.resource_groups, module.data_subnet, module.vnet_peering]
}

module "key_vault_secrets" {
  source       = "./modules/06-Key_Vault_Secret"
  for_each     = var.key_vault_secrets
  secret_name  = each.value.secret_name
  secret_value = each.value.secret_value
  vault_name   = each.value.vault_name
  key_vault_rg = module.resource_groups.rg_name_out
  depends_on   = [module.key_vault, module.vnet_peering]
}





module "log_analytics_workspace" {
  source                       = "./modules/13-Log_Analytics_Workspace"
  for_each                     = var.log_analytics_workspace
  log_analytics_workspace_name = each.value.log_analytics_workspace_name
  resource_group_name          = module.resource_groups.rg_name_out
  location                     = module.resource_groups.rg_location_out
  law_sku                      = each.value.law_sku
  retention_in_days            = each.value.retention_in_days
  tags                         = var.tags
  depends_on                   = [module.resource_groups, module.vnet_peering]

}

module "application_insights" {
  source                       = "./modules/14-Application_Insights"
  for_each                     = var.application_insights
  app_insight_name             = each.value.app_insight_name
  resource_group_name          = module.resource_groups.rg_name_out
  location                     = module.resource_groups.rg_location_out
  log_analytics_workspace_name = each.value.log_analytics_workspace_name
  application_type             = each.value.application_type
  tags                         = var.tags
  depends_on                   = [module.resource_groups, module.log_analytics_workspace, module.vnet_peering]
}

module "container_registry" {
  source                        = "./modules/15-Container_Registry"
  for_each                      = var.container_registry
  acr_name                      = each.value.acr_name
  resource_group_name           = module.resource_groups.rg_name_out
  location                      = module.resource_groups.rg_location_out
  sku                           = each.value.sku
  admin_enabled                 = each.value.admin_enabled
  public_network_access_enabled = each.value.public_network_access_enabled
  tags                          = var.tags
  virtual_network_name          = module.virtual_networks.vnet_name_out
  subnet_name                   = module.data_subnet.data_snet_name_out
  hub_resource_group_name       = var.hub_resource_group_name
  depends_on                    = [module.resource_groups, module.data_subnet,module.vnet_peering]
}





module "vnet_peering" {
  source                   = "./modules/19-Virtual_Network_Peering"
  virtual_network_name     = module.virtual_networks.vnet_name_out
  hub_virtual_network_name = var.hub_virtual_network_name
  resource_group_name      = module.resource_groups.rg_name_out
  hub_resource_group_name  = var.hub_resource_group_name
  depends_on               = [module.virtual_networks, module.data_subnet]
}

module "data_subnet" {
  source               = "./modules/23-Data_Subnet"
  subnet_name          = var.data_subnet_name
  subnet_address_space = var.data_subnet_address_space
  resource_group_name  = module.resource_groups.rg_name_out
  virtual_network_name = module.virtual_networks.vnet_name_out
  depends_on           = [module.virtual_networks]
}
