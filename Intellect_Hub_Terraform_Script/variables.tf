# End of the Subscription Details

// Variable for Organization Name for Azure Resource Group
variable "org_name" {
  description = "Organization Name for Azure Resource Group"
  type        = string
  default     = "Intellect"
}
// Variable for Environment Name for Azure Resource Group
variable "env_name" {
  description = "Environment Name for Azure Resource Group"
  type        = string
  default     = "Dev"
}

// Variable for Client Name for Azure Resource Group
variable "client_name" {
  description = "Client Name for Azure Resource Group"
  type        = string
  default     = "purple_fabric"
}

// Variable for Region Code for Azure Resource Group
variable "region_code" {
  description = "Region Code for Azure Resource Group"
  type        = string
  default     = "eus"
}

// Variable for Cloud Provider for Azure Resource Group
variable "cloud_provider" {
  description = "Cloud Provider for Azure Resource Group"
  type        = string
  default     = "Azure"
}

// Variable for Location for Azure Resource Group
variable "location" {
  description = "Location for Azure Resource Group"
  type        = string
  default     = "East US"
}

// Variable for Tags for Azure Resource Group
variable "tags" {
  type = map(string)
  default = {
    "CreatedBy" = "Terraform"
  }
  description = "Tags For the Deployment Resource"
}

variable "resource_group_enabled" {
  description = "Whether to create a resource group"
  type        = bool
  default     = true
}


// Varibles for Azure Virtual Network
variable "virtual_network_enabled" {
  description = "Whether to create a virtual network"
  type        = bool
  default     = true
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}
// End Of Varibles for Azure Virtual Network

// Variable for azure Key Vault
variable "key_vault_enabled" {
  description = "Whether to create a Key Vault"
  type        = bool
  default     = true
}
variable "sku_name" {
  type        = string
  description = "The SKU of the vault to be created."
  default     = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "The sku_name must be one of the following: standard, premium."
  }
}

variable "key_permissions" {
  type        = list(string)
  description = "List of key permissions."
  default     = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
}

variable "secret_permissions" {
  type        = list(string)
  description = "List of secret permissions."
  default     = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
}

variable "certificate_permissions" {
  type        = list(string)
  description = "List Of certificate permissions"
  default     = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. If this value isn't null (the default), 'data.azurerm_client_config.current.object_id' will be set to this value."
  default     = null
}
// End of the Key Vault Variables
// Azure Key Vault Secrets Variables
variable "key_vault_secret_enabled" {
  description = "Whether to create a Key Vault Secret"
  type        = bool
  default     = true
}

variable "key_vault_secrets" {
  type = map(object({
    secret_name  = string
    secret_value = string
  }))
  default = {}
}
// End Of Azure Key Vault Secrets Variables
// Azure Storage Account Variables
variable "storage_account_enabled" {
  description = "Whether to create a Storage Account"
  type        = bool
  default     = true
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = null
}

variable "account_tier" {
  description = "The tier of the storage account (Standard or Premium)"
  type        = string
  default     = null
}

variable "account_replication_type" {
  description = "The replication type for the storage account"
  type        = string
  default     = null
}

variable "public_network_access_enabled" {
  type        = bool
  description = "value to enable or disable public network access"
  default     = null
}
// End Of Azure Storage Account Variables

// End Of Azure Virtual Network Gateway Variables
# Azure Virtual Machine For Linux Variables
variable "vm_enabled" {
  description = "Whether to create a Virtual Machine Linux"
  type        = bool
  default     = true
}


variable "lin_security_rules" {
  description = "Configuration of the Security Rules"
  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = {}
}

variable "lin_admin_username" {
  description = "Username for the Virtual Machine Linux"
  type        = string
  default     = null
}

variable "lin_vm_size" {
  description = "Size of the Virtual Machine Linux"
  type        = string
  default     = null
}

variable "lin_storage_account_type" {
  description = "Type of the storage account"
  type        = string
  default     = "Standard_LRS"
  validation {
    condition     = contains(["Standard_LRS", "StandardSSD_LRS", "Premium_LRS", "StandardSSD_ZRS", "Premium_ZRS"], var.lin_storage_account_type)
    error_message = "The sku must be one of the following:Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS."
  }
}

variable "lin_os_disk_size" {
  description = "Size of the OS Disk"
  type        = number
  default     = null
}

variable "lin_publisher" {
  description = "Publisher of the image"
  type        = string
  default     = null
}

variable "lin_offer" {
  description = "Offer of the image"
  type        = string
  default     = null
}

variable "lin_image_sku" {
  description = "SKU of the image"
  type        = string
  default     = null
}

variable "lin_version" {
  description = "Version of the image"
  type        = string
  default     = null
}

variable "subnet_address_space" {
  description = "Address space for the Virtual Machine subnet"
  type        = string
  default     = null
}

# End Of Azure Virtual Machine For Linux Variables

variable "pvt_dns_enable" {
  description = "Enable or disable private DNS zone creation"
  type        = bool
  default     = false
}