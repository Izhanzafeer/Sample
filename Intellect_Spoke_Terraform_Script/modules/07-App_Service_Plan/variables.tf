variable "location" {
  description = "Location of the virtual network"
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of the app service plan"
  type        = string
}

variable "app_service_sku_name" {
  description = "SKU of the app service plan"
  type        = string
}

variable "app_service_os_type" {
  description = "OS type of the app service plan"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the regional resource group"
  type        = string
}

variable "tags" {
  description = "value of the tags"
  type        = map(string)
}
