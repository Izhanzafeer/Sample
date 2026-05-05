variable "resource_group_name" {
  description = "Resource group name for the Redis cache"
  type        = string
}

variable "location" {
  description = "Location for the Redis cache"
  type        = string
}

variable "redis_name" {
  description = "Name of the Redis cache"
  type        = string
}

variable "capacity" {
  description = "Capacity of the Redis cache"
  type        = number
  validation {
    condition     = contains([0, 1, 2, 3, 4, 5, 6], var.capacity)
    error_message = "The capacity must be one of the following: SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4, 5."
  }
}

variable "family" {
  description = "Family of the Redis cache"
  type        = string
  validation {
    condition     = contains(["C", "P"], var.family)
    error_message = "The family must be one of the following: Valid values are C (for Basic/Standard SKU family) and P (for Premium)."
  }
}

variable "sku_name" {
  description = "SKU name of the Redis cache"
  type        = string
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_name)
    error_message = "The sku must be one of the following: Basic, Standard and Premium."
  }
}

variable "enable_non_ssl_port" {
  description = "Whether non-SSL port is enabled for the Redis cache"
  type        = bool
  default     = false
}

variable "minimum_tls_version" {
  description = "Minimum TLS version supported by the Redis cache"
  type        = string
  default     = "1.2"
  validation {
    condition     = contains(["1.2"], var.minimum_tls_version)
    error_message = "The minimum_tls_version must be one of the following: 1.2."
  }
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the Redis cache"
  type        = bool
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Terraform Testing"
  }
  description = "Tags For the Deployment Resource"
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