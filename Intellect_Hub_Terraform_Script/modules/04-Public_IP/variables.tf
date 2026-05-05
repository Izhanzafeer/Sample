variable "public_ip_name" {
  type        = string
  description = "Name for the public IP address"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where the public IP address will be created"
}

variable "location" {
  type        = string
  description = "Location for the public IP address"
}

variable "allocation_method" {
  type        = string
  description = "Allocation method for the public IP address"
}

variable "sku" {
  type        = string
  description = "SKU for the public IP address"
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Terraform Testing"
  }
  description = "A map of tags to apply to the Key Vault"
}