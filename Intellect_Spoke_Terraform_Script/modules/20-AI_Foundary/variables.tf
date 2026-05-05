variable "location" {
  description = "The location of the resource group."
  type        = string
}

variable "resource_group_name" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "ai_foundry_name" {
  type        = string
  default     = "ai"
  description = "ai foundry name"
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Terraform Testing"
  }
  description = "Tags For the Deployment Resource"
}

variable "vault_name" {
  type        = string
  description = "The name of the key vault to be created. The value will be randomly generated if blank."
  default     = ""
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}