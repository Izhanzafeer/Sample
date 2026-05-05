module "resource_groups" {
  count          = var.resource_group_enabled ? 1 : 0
  source         = "./modules/01-Resource_Groups"
  org_name       = local.org_name
  env_name       = local.env_name
  region_code    = local.region_code
  client_name    = local.client_name
  cloud_provider = local.cloud_provider
  location       = local.location
  tags           = local.tags
}

module "virtual_networks" {
  count               = var.virtual_network_enabled ? 1 : 0
  source              = "./modules/02-Virtual_Networks"
  org_name            = local.org_name
  env_name            = local.env_name
  region_code         = local.region_code
  cloud_provider      = local.cloud_provider
  location            = local.location
  client_name         = local.client_name
  address_space       = var.vnet_address_space
  resource_group_name = module.resource_groups[0].resource_group_name
  tags                = local.tags
  depends_on          = [module.resource_groups]
}

module "key_vault" {
  count                   = var.key_vault_enabled ? 1 : 0
  source                  = "./modules/05-Key_Vault"
  location                = local.location
  key_vault_rg            = module.resource_groups[0].resource_group_name
  org_name                = local.org_name
  env_name                = local.env_name
  region_code             = local.region_code
  cloud_provider          = local.cloud_provider
  client_name             = local.client_name
  sku_name                = var.sku_name
  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  certificate_permissions = var.certificate_permissions
  msi_id                  = var.msi_id
  tags                    = local.tags
  depends_on              = [module.resource_groups]
}

module "key_vault_secrets" {
  for_each     = var.key_vault_secret_enabled ? var.key_vault_secrets : {}
  source       = "./modules/06-Key_Vault_Secret"
  secret_name  = each.value.secret_name
  secret_value = each.value.secret_value
  key_vault_id = module.key_vault[0].key_vault_id_out
  depends_on   = [module.key_vault]
}

module "storage_account" {
  count                         = var.storage_account_enabled ? 1 : 0
  source                        = "./modules/07-Storage_Account"
  storage_account_name          = var.storage_account_name
  resource_group_name           = module.resource_groups[0].resource_group_name
  location                      = local.location
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = local.tags
  depends_on                    = [module.resource_groups]
}



module "virtual_machines" {
  count                = var.vm_enabled ? 1 : 0
  source               = "./modules/09-Virtual_Machine"
  resource_group_name  = module.resource_groups[0].resource_group_name
  location             = local.location
  virtual_network_name = module.virtual_networks[0].virtual_network_name
  admin_username       = var.lin_admin_username
  vm_size              = var.lin_vm_size
  storage_account_type = var.lin_storage_account_type
  disk_size            = var.lin_os_disk_size
  security_rules       = var.lin_security_rules
  publisher            = var.lin_publisher
  offer                = var.lin_offer
  sku                  = var.lin_image_sku
  resource_group_id    = module.resource_groups[0].resource_group_id
  os_version           = var.lin_version
  subnet_address_space = var.subnet_address_space
  tags                 = local.tags
  org_name             = local.org_name
  env_name             = local.env_name
  region_code          = local.region_code
  cloud_provider       = local.cloud_provider
  client_name          = local.client_name
  depends_on           = [module.resource_groups, module.virtual_networks]
}




module "private_dns_zone" {
  count                = var.pvt_dns_enable ? 1 : 0
  source               = "./modules/11-Pvt_DNS_Zone"
  resource_group_name  = module.resource_groups[0].resource_group_name
  tags                 = local.tags
  virtual_network_name = module.virtual_networks[0].virtual_network_name
  depends_on           = [module.resource_groups, module.virtual_networks]
}