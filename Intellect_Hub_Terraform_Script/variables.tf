variable "resource_group_enabled" {
  type    = bool
  default = true
}

variable "virtual_network_enabled" {
  type    = bool
  default = true
}

variable "key_vault_enabled" {
  type    = bool
  default = true
}

variable "storage_account_enabled" {
  type    = bool
  default = true
}

variable "vm_enabled" {
  type    = bool
  default = true
}

variable "pvt_dns_enable" {
  type    = bool
  default = false
}