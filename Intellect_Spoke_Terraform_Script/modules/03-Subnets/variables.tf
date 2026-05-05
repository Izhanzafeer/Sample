variable "subnet_name" {
  type        = string
  default     = "default"
  description = "The Subnet for Azure Virtual Network"
}

variable "subnet_address_space" {
  type        = string
  default     = "default"
  description = "The Subnet Address space for Azure Virtual Network"
}

variable "resource_group_name" {
  type        = string
  default     = "rg"
  description = "The name of the Resource Group for the Virtual Network"
}

variable "virtual_network_name" {
  type        = string
  default     = "vnet"
  description = "The name of the Virtual Network will be created"
}