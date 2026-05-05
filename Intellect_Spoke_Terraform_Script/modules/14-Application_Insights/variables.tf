variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "The name of the log analytics workspace  will be created"
}

variable "location" {
  description = "The location of the resource group."
  type        = string
}


variable "app_insight_name" {
  type        = string
  description = "The name of the application insight  will be created"
}

variable "application_type" {
  type        = string
  description = "Type of the application"
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Terraform Testing"
  }
  description = "A map of tags to apply to the Virtual Network"
}