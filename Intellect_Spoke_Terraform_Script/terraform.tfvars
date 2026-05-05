# Configuration for the Hub and Spoke Tenant Details
 tenant_id = "75f2a99b-01fd-48f2-ac60-d4a7a44fd0cc"
# # End of the Hub and Spoke Tenant Details
# # Configuration for the Spoke Subscription Details
 spoke_subscription_id = "54ff4cf6-32b8-4112-ac42-05a514813214"
# # End of the Spoke Subscription Details

# Resource Group Configuration
resource_group_name = "INT-PROD-SPOKE-CIN-PF"
location            = "central india"
# End Of Resource Group Configuration
# Hub Resource Configuration
hub_resource_group_name  = "RG-INT-PROD-CIN-PF"
hub_virtual_network_name = "VNET-INT-PROD-CIN-PF"
# End of Hub Resource Configuration

# Azure Virtual Networks Configuration
vnet_address_space = "10.2.0.0/20"
# End Of Azure Virtual Networks Configuration
# Azure Subnets Configuration
data_subnet_name          = "data"
data_subnet_address_space = "10.2.0.64/26"
# # # Azure Subnets Configuration
# # End Of Azure Subnets Configuration
# Azure Key Vault Configuration
key_vault = {
  "int-spoke-01" = {
    vault_name              = "pfprodspoke"
    sku                     = "standard"
    key_permissions         = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
    secret_permissions      = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
    certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
  }
}
# End Of Azure Key Vault Configuration
# Azure Key Vault Secrets Configuration
key_vault_secrets = {
  "int-01" = {
    secret_name  = "pf-secret"
    secret_value = "pf-secret-value"
    vault_name   = "pfprodspoke"
  }
}
# End Of Azure Key Vault Secrets Configuration


# Azure Redis Cache Configuration
redis_cache = {
  "int-01" = {
    redis_name                    = "INT-PROD-SPOKE-CIN-PF"
    capacity                      = 1
    family                        = "C"
    sku_name                      = "Basic"
    enable_non_ssl_port           = false
    minimum_tls_version           = "1.2"
    public_network_access_enabled = true
  }
}
# End Of Azure Redis Cache Configuration
# Azure Log Analytics Workspace Configuration
log_analytics_workspace = {
  "int-01" = {
    log_analytics_workspace_name = "INT-PROD-SPOKE-CIN-PF"
    law_sku                      = "PerGB2018"
    retention_in_days            = 30
  }
}
# End Of Azure Log Analytics Workspace Configuration
# Azure Application Insights Configuration
application_insights = {
  "int-01" = {
    app_insight_name             = "INT-PROD-SPOKE-CIN-PF"
    application_type             = "web"
    log_analytics_workspace_name = "INT-PROD-SPOKE-CIN-PF"
  }
}
# End Of Azure Application Insights Configuration
# Azure Container Registry Configuration
container_registry = {
  "int-01" = {
    acr_name                      = "pfprodspoke"
    sku                           = "Premium"
    admin_enabled                 = true
    public_network_access_enabled = false
  }
}
