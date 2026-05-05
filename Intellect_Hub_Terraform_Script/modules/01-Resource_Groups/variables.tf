// Variable for Organization Name for Azure Resource Group
variable "org_name" {
  description = "Organization Name for Azure Resource Group"
  type        = string
  default     = "intellect"
}

// Variable for Environment Name for Azure Resource Group
variable "env_name" {
  description = "Environment Name for Azure Resource Group"
  type        = string
  default     = "Dev"
}

// Variable for Client Name for Azure Resource Group
variable "client_name" {
  description = "Client Name for Azure Resource Group"
  type        = string
  default     = "intellect"
}

// Variable for Region Code for Azure Resource Group
variable "region_code" {
  description = "Region Code for Azure Resource Group"
  type        = string
  default     = "eus"
}

// Variable for Cloud Provider for Azure Resource Group
variable "cloud_provider" {
  description = "Cloud Provider for Azure Resource Group"
  type        = string
  default     = "Azure"
}

// Variable for Location for Azure Resource Group
variable "location" {
  description = "Location for Azure Resource Group"
  type        = string
  default     = "East US"
}

// Variable for Tags for Azure Resource Group
variable "tags" {
  type = map(string)
  default = {
    "CreatedBy" = "Terraform"
  }
  description = "Tags For the Deployment Resource"
}