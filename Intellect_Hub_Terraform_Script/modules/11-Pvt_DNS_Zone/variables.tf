variable "virtual_network_name" {
  description = "Name of the virtual network where the Virtual Machine Linux will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Terraform Testing"
  }
  description = "A map of tags to apply to the Virtual Network"
}