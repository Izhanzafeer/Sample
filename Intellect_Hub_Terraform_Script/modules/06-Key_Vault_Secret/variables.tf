variable "secret_name" {
  type        = string
  description = "The Secret Name to be added"
}

variable "secret_value" {
  type        = string
  description = "The Secret values to be added"
}

variable "key_vault_rg" {
  type        = string
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
  default     = "rg"
}

variable "key_vault_id" {
  type        = string
  description = "id of the Key Vault where the secret will be stored"
}