variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location of the resource group."
  type        = string
}

variable "acr_name" {
  description = "The name of the container registry."
  type        = string
}

variable "admin_enabled" {
  description = "Whether admin user is enabled."
  type        = bool
}

variable "sku" {
  description = "The SKU of the container registry."
  type        = string
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "The sku must be one of the following: Basic, Standard and Premium."
  }
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled."
  type        = bool
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Terraform Testing"
  }
  description = "A map of tags to apply to the Virtual Network"
}

variable "virtual_network_name" {
  type        = string
  default     = "vnet"
  description = "The name of the Virtual Network will be created"
}
variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}
variable "hub_resource_group_name" {
  type        = string
  description = "Azure resource group name where the Hub Services will create will be available."
}
