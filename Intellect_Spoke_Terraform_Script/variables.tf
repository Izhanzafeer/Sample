# #  Variables for the Hub and Spoke Tenant Details
 variable "tenant_id" {
   description = "The Tenant ID of the Hub Subscription"
  type        = string
 }
# # End of the Hub and Spoke Tenant Details

# # Variables for the Spoke Subscription Details
 variable "spoke_subscription_id" {
   description = "The Subscription ID of the Spoke Subscription"
  type        = string
 }
# End of the Spoke Subscription Details

# Azure Resource Group Variables

variable "location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Terraform Testing"
  }
  description = "Tags For the Deployment Resource"
}
# End Of Azure Resource Group Variables
# Hub Resource Group Variables
variable "hub_resource_group_name" {
  type        = string
  description = "Azure resource group name where the Hub Services will create will be available."
}
variable "hub_virtual_network_name" {
  type        = string
  default     = "vnet"
  description = "The name of the Virtual Network will be created"
}
# End of Hub Resource Group Variables

# Azure Virtual Networks Subnets Variables
variable "vnet_address_space" {
  type        = string
  default     = "vnet"
  description = "The name of the Virtual Network will be created"
}
# Azure Key Vault Variables
variable "key_vault" {
  type = map(object({
    vault_name              = string
    sku                     = string
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
    msi_id                  = optional(string)
  }))
  description = "Map of Key Vaults to create."
}
# End Of Azure Key Vault Variables
# Azure Key Vault Secrets Variables
variable "key_vault_secrets" {
  type = map(object({
    
    secret_name  = string
    secret_value = string
    vault_name   = string
  }))
}
# End Of Azure Key Vault Secrets Variables


# Azure Log Analytics Workspace Variables
variable "log_analytics_workspace" {
  type = map(object({
    log_analytics_workspace_name = string
    law_sku                      = string
    retention_in_days            = number
  }))
  description = "Map of Log Analytics Workspace to create."
}
# End Of Azure Log Analytics Workspace Variables
# Azure Application Insights Variables
variable "application_insights" {
  type = map(object({
    app_insight_name             = string
    application_type             = string
    log_analytics_workspace_name = string
  }))
  description = "Map of Application Insights to create."
}
# End Of Azure Application Insights Variables
# Azure Container Registry Variables
variable "container_registry" {
  type = map(object({
    acr_name                      = string
    admin_enabled                 = optional(bool, false)
    sku                           = string
    public_network_access_enabled = optional(bool, true)

  }))
  description = "Map of Container Registry to create."
}
# End Of Azure Container Registry Variables

# Data Subnet Variables
variable "data_subnet_name" {
  type        = string
  default     = "data"
  description = "The name of the subnet will be created"
}

variable "data_subnet_address_space" {
  type        = string
  default     = "data"
  description = "The name of the subnet will be created"
}
# End of Data Subnet Variables

