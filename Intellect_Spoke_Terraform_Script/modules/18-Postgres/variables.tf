variable "resource_group_name" {
  description = "Resource group name for PostgreSQL flexible server"
  type        = string
}

variable "location" {
  description = "Location for PostgreSQL flexible server"
  type        = string
}

variable "postgresql_flexible_server_name" {
  description = "Name of the PostgreSQL flexible server"
  type        = string
}

variable "psql_version" {
  description = "Version of PostgreSQL"
  type        = string
  default     = "15"
}

variable "administrator_login" {
  description = "Administrator login for PostgreSQL flexible server"
  type        = string
  default     = "psqladmin"
}

variable "key_vault_name" {
  type        = string
  description = "The name of the key vault to be created. The value will be randomly generated if blank."
  default     = ""
}


variable "zone" {
  description = "Zone for PostgreSQL flexible server"
  type        = string
  default     = "1"
}

variable "storage_mb" {
  description = "Storage capacity for PostgreSQL flexible server in MB"
  type        = number
  default     = 32768
  validation {
    condition     = contains([32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4193280, 4194304, 8388608, 16777216, 33553408], var.storage_mb)
    error_message = "The storage_mb must be one of the following: 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4193280, 4194304, 8388608, 16777216 and 33553408."
  }
}

variable "storage_tier" {
  description = "Storage tier for PostgreSQL flexible server"
  type        = string
  default     = ""
  validation {
    condition     = contains(["P4", "P6", "P10", "P15", "P20", "P30", "P40", "P50", "P60", "P70", "P80", ""], var.storage_tier)
    error_message = "The storage_tier must be one of the following: P4, P6, P10, P15,P20, P30,P40, P50,P60, P70 or P80.Default value is dependant on the storage_mb value."
  }
}

variable "sku_name" {
  description = "SKU name for PostgreSQL flexible server"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for PostgreSQL flexible server"
  type        = bool
  default     = false
}

variable "auto_grow_enabled" {
  description = "Whether auto grow is enabled for PostgreSQL flexible server"
  type        = bool
}

variable "virtual_network_name" {
  type        = string
  default     = "vnet"
  description = "The name of the Virtual Network will be created"
}
variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "tags" {
  description = "Tags for PostgreSQL flexible server"
  type        = map(string)
}

variable "hub_resource_group_name" {
  type        = string
  description = "Azure resource group name where the Hub Services will create will be available."
}

variable "kv_database_hostname_name" {
  type        = string
  description = "Name for stroing the secret in the Key vault for Database hostname"
}

variable "kv_database_username_name" {
  type        = string
  description = "Name for stroing the secret in the Key vault for Database hostname"
}

variable "kv_database_password_name" {
  type        = string
  description = "Name for stroing the secret in the Key vault for Database hostname"
}