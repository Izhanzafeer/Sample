variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location of the resource group."
  type        = string
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "The name of the log analytics workspace  will be created"
}

variable "law_sku" {
  type        = string
  default     = "PerGB2018"
  description = "The SKU of Log Analytics Workspace"
}

variable "retention_in_days" {
  type        = number
  default     = 30
  description = "The SKU of Log Analytics Workspace"
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Terraform Testing"
  }
  description = "A map of tags to apply to the Virtual Network"
}
