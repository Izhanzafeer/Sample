variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
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

variable "hub_virtual_network_name" {
  type        = string
  default     = "vnet"
  description = "The name of the Virtual Network will be created"
}