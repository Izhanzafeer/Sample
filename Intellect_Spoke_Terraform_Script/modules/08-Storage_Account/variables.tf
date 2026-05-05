variable "resource_group_name" {
  description = "Name of the regional resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "account_tier" {
  description = "The tier of the storage account (Standard or Premium)"
  type        = string
}

variable "account_replication_type" {
  description = "The replication type for the storage account"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
}

variable "public_network_access_enabled" {
  type        = bool
  description = "value to enable or disable public network access"
}

variable "virtual_network_name" {
  type        = string
  default     = "vnet"
  description = "The name of the Virtual Network will be created"
}

variable "hub_resource_group_name" {
  type        = string
  description = "Azure resource group name where the Hub Services will create will be available."
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}