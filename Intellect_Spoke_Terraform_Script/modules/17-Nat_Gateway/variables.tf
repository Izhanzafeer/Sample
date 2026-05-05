variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the public IP address will be created"
}

variable "location" {
  description = "The Azure region where the resources will be created"
  type        = string
}

variable "virtual_network_name" {
  type        = string
  default     = "vnet"
  description = "The name of the Virtual Network will be created"
}

variable "subnet_address_space" {
  description = "User name"
  type        = string
}

variable "nat_gateway_name" {
  description = "The name of the NAT Gateway"
  type        = string
}

variable "sku" {
  description = "The SKU of the NAT Gateway"
  type        = string
}

variable "idle_timeout_in_minutes" {
  description = "The idle timeout in minutes for the NAT Gateway"
  type        = number
}

variable "allocation_method" {
  description = "The allocation method for the Public IP"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
}
