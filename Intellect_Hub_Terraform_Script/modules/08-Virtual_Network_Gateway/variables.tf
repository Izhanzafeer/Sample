variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  type        = string
  description = "Location for the VPN Gateway"
}

variable "virtual_network_name" {
  description = "Name of the virtual network where the VPN Gateway will be deployed"
  type        = string
}

variable "vpngw_sku" {
  description = "sku for the VPN Gateway"
  type        = string
  default     = "VpnGw1"
  validation {
    condition     = contains(["HighPerformance", "UltraPerformance", "ErGw1AZ", "ErGw2AZ", "ErGw3AZ", "VpnGw1", "VpnGw2", "VpnGw3", "VpnGw4", "VpnGw5", "VpnGw1AZ", "VpnGw2AZ", "VpnGw3AZ", "VpnGw4AZ", "VpnGw5AZ"], var.vpngw_sku)
    error_message = "The vpngw_sku must be one of the following: HighPerformance, UltraPerformance, ErGw1AZ, ErGw2AZ, ErGw3AZ, VpnGw1, VpnGw2, VpnGw3, VpnGw4,VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ,VpnGw4AZ and VpnGw5AZ and depend on the type, vpn_type and generation arguments. A PolicyBased gateway only supports the Basic SKU. Further, the UltraPerformance SKU is only supported by an ExpressRoute gateway."
  }
}

variable "vpngw_type" {
  description = "Type for the VPN Gateway"
  type        = string
  default     = "Vpn"
  validation {
    condition     = contains(["Vpn", "ExpressRoute"], var.vpngw_type)
    error_message = "The vpngw_type must be one of the following: Vpn or ExpressRoute."
  }
}

variable "vpngw_generation" {
  description = "Generations for the VPN Gateway"
  type        = string
  default     = "Generation1"
  validation {
    condition     = contains(["Generation1", "Generation2"], var.vpngw_generation)
    error_message = "The vpngw_generation must be one of the following: Generation1 or Generation2."
  }
}

variable "vpngw_vpn_type" {
  description = "VPN Type for the VPN Gateway"
  type        = string
  default     = "RouteBased"
  validation {
    condition     = contains(["RouteBased", "PolicyBased"], var.vpngw_vpn_type)
    error_message = "The vpngw_vpn_type must be one of the following: RouteBased or PolicyBased."
  }
}

variable "vpngw_active_active" {
  description = "VPN active_active for the VPN Gateway"
  type        = bool
  default     = false
}

variable "vpngw_bgp" {
  description = "BGP for the VPN Gateway"
  type        = bool
  default     = false
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Terraform Testing"
  }
  description = "Tags For the Deployment Resource"
}

variable "vpngw_subnet_address_space" {
  description = "Address space for the VPN Gateway subnet"
  type        = string
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