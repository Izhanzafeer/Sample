variable "resource_group_name" {
  description = "Name of the regional resource group"
  type        = string
}

variable "logic_app_name" {
  description = "The name of the logic app"
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
