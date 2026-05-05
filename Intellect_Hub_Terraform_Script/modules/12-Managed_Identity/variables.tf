variable "location" {
  description = "location where the resources will be created"
  type        = string
  
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Terraform Testing"
  }
  description = "A map of tags to apply to the Virtual Network"
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

// Variable for Organization Name for Azure Virtual Network
variable "org_name" {
  description = "Organization Name for Azure Virtual Network"
  type        = string
  default     = "intellect"
}

// Variable for Environment Name for Azure Virtual Network
variable "env_name" {
  description = "Environment Name for Azure Virtual Network"
  type        = string
  default     = "Dev"
}

// Variable for Region Code for Azure Virtual Network
variable "region_code" {
  description = "Region Code for Azure Virtual Network"
  type        = string
  default     = "eus"
}

// Variable for Client Name for Azure Virtual Network
variable "client_name" {
  description = "Client Name for Azure Virtual Network"
  type        = string
  default     = "intellect"
}


// Variable for Cloud Provider for Azure Virtual Network
variable "cloud_provider" {
  description = "Cloud Provider for Azure Virtual Network"
  type        = string
  default     = "Azure"
}

variable "key_vault_id" {
  type        = string
  description = "id of the Key Vault where the secret will be stored"
}