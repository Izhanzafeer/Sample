variable "location" {
  description = "The location of the resource group."
  type        = string
}

variable "resource_group_name" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}


variable "ai_service_name" {
  description = "name of the ai services"
  type        = string
}

variable "ai_service_sku" {
  description = "sku of the ai services"
  type        = string
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Terraform Testing"
  }
  description = "Tags For the Deployment Resource"
}