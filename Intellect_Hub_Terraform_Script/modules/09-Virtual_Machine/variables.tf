variable "resource_group_name" {
  description = "Resource group name for the Virtual Machine Linux"
  type        = string
}

variable "location" {
  description = "Location for the Virtual Machine Linux"
  type        = string
}

variable "subnet_address_space" {
  description = "subnet address space for the Virtual Machine Linux"
  type        = string
}

variable "resource_group_id" {
  description = "Resource group ID for the Virtual Machine Linux"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network where the Virtual Machine Linux will be deployed"
  type        = string
}

variable "security_rules" {
  description = "Configuration of the Security Rules"
  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "admin_username" {
  description = "Username for the Virtual Machine Linux"
  type        = string
}

variable "vm_size" {
  description = "Size of the Virtual Machine Linux"
  type        = string
}



variable "storage_account_type" {
  description = "Type of the storage account"
  type        = string
  default     = "Standard_LRS"
  validation {
    condition     = contains(["Standard_LRS", "StandardSSD_LRS", "Premium_LRS", "StandardSSD_ZRS", "Premium_ZRS"], var.storage_account_type)
    error_message = "The sku must be one of the following:Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS."
  }
}
variable "disk_size" {
  description = "Size of the OS Disk"
  type        = number
}

variable "publisher" {
  description = "Publisher of the image"
  type        = string
}

variable "offer" {
  description = "Offer of the image"
  type        = string
}

variable "sku" {
  description = "SKU of the image"
  type        = string
}

variable "os_version" {
  description = "Version of the image"
  type        = string
}

variable "tags" {
  description = "Tags for the Virtual Machine Linux"
  type        = map(string)
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