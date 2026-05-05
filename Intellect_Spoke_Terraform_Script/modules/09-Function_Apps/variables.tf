variable "resource_group_name" {
  description = "Name of the regional resource group"
  type        = string
}

variable "tags" {
  description = "value of the tags"
  type        = map(string)
}
variable "location" {
  description = "Location of the virtual network"
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of the app service plan"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "function_app_name" {
  description = "The name of the function app"
  type        = string
}
variable "always_on" {
  description = "Enable always on for the function app"
  type        = bool
}

variable "os_type" {
  description = "The OS type of the function app (Windows or Linux)"
  type        = string
  
}

variable "acr_name" {
  description = "The name of the container registry."
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

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}