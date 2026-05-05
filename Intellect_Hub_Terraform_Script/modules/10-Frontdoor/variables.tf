variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Terraform Testing"
  }
  description = "A map of tags to apply to the Virtual Network"
}

variable "sku_name" {
  description = "The SKU of the service bus namespace"
  type        = string
  default = "Standard"
}

// Variable for Organization Name for Azure Virtual Network
variable "org_name" {
  description = "Organization Name for Azure Virtual Network"
  type        = string
  default     = "intellect"
}

// Variable for Environment Name for Azure Virtual Network
variable "env_name" {
  description = "Environment Name for Azure Virtual Network"
  type        = string
  default     = "Dev"
}

// Variable for Region Code for Azure Virtual Network
variable "region_code" {
  description = "Region Code for Azure Virtual Network"
  type        = string
  default     = "eus"
}

// Variable for Client Name for Azure Virtual Network
variable "client_name" {
  description = "Client Name for Azure Virtual Network"
  type        = string
  default     = "intellect"
}


// Variable for Cloud Provider for Azure Virtual Network
variable "cloud_provider" {
  description = "Cloud Provider for Azure Virtual Network"
  type        = string
  default     = "Azure"
}