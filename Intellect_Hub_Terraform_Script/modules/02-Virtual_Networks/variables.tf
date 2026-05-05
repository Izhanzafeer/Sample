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

// Variable for Location for Azure Virtual Network
variable "location" {
  description = "Location for Azure Virtual Network"
  type        = string
  default     = "East US"
}

// Variable for Address Space for Azure Virtual Network
variable "address_space" {
  description = "Address Space for Azure Virtual Network"
  type        = list(string)
  default     = [""]
}

// Variable for Resource Group Name for Azure Virtual Network
variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = ""
}

// Variable for Tags for Azure Virtual Network
variable "tags" {
  type = map(string)
  default = {
    "CreatedBy" = "Terraform"
  }
  description = "Tags For the Deployment Resource"
}