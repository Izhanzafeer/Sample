variable "resource_group_name" {
  description = "Name of the regional resource group"
  type        = string
}

variable "service_bus_namespace_name" {
  description = "The name of the service bus namespace"
  type        = string
}

variable "sku" {
  description = "The SKU of the service bus namespace"
  type        = string
  default = "Standard"
}

variable "tags" {
  description = "value of the tags"
  type        = map(string)
}
variable "location" {
  description = "Location of the virtual network"
  type        = string
}

variable "capacity" {
  description = "Capacity of the service bus namespace"
  type        = number
}

variable "premium_messaging_partitions" {
  description = "Capacity of the service bus namespace"
  type        = number
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