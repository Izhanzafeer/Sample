variable "aks_cluster_name" {
  type        = string
  description = "AKS cluster name"
}

variable "sku_tier" {
  type        = string
  description = "Pricing tier of the aks cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "Version of aks cluster"
}

variable "azure_policy_enabled" {
  type        = bool
  description = "Enabling azure policy"
}

variable "location" {
  type        = string
  description = "Azure region where the AKS cluster will be created"
}

variable "subnet_address_space" {
  description = "User name"
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "Azure resource group name where the AKS cluster will be created"
}

variable "node_resource_group" {
  type        = string
  description = "Name of the node resource group"
}

variable "nat_gateway_name" {
  type        = string
  description = "Name of the nat gateway"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "name of the log analytics workspace"
}

variable "law_sku" {
  type        = string
  description = "size of the log analytics workspace"
}


variable "virtual_network_name" {
  type        = string
  description = "name of the existing virtual network"
}

# variable "nat_subnet_name" {
#   type        = string
#   description = "subnet name of the existing virtual network"
# }

variable "vault_name" {
  type        = string
  description = "The name of the key vault to be created. The value will be randomly generated if blank."
  default     = ""
}


variable "network_plugin" {
  type        = string
  description = "network plugin"
}

variable "identity_type" {
  type        = string
  description = "type of the identity"
}

# variable "container_registry_id" {
#   type        = string
#   description = "Id of the container registry that need to be integrated with the cluster"
# }


variable "tags" {
  type = map(string)
  default = {
    "Environment" = "Terraform Testing"
  }
  description = "Tags For the Deployment Resource"
}

variable "email_reciever_name" {
  type        = string
  description = "Name of the person who is going to recieve the aks alerts"
}

variable "email_reciever_id" {
  type        = string
  description = "email ID of the person who is going to recieve the aks alerts"
}

# variable "key_vault_id" {
#   type        = string
#   description = "ID of the app gateway which you need to enable AGIC"
# }

variable "k8s_key_permissions" {
  type        = list(string)
  description = "List of key permissions."
  default     = ["Get"]
}

variable "k8s_secret_permissions" {
  type        = list(string)
  description = "List of secret permissions."
  default     = ["Get"]
}

variable "nodepools" {
  description = "Nodepools for the Kubernetes cluster"
  type = map(object({
    name                 = string
    vm_size              = string
    node_count           = number
    mode                 = string
    os_type              = string
    os_disk_size_gb      = number
    auto_scaling_enabled = bool
    min_count            = number
    max_count            = number
    max_pods             = number
    node_labels          = map(string)
    }
  ))
  default = {
    default = {
      name                 = "default"
      vm_size              = "Standard_D2_v2"
      node_count           = 1
      mode                 = ""
      os_type              = "Linux"
      os_disk_size_gb      = 30
      auto_scaling_enabled = true
      min_count            = 1
      max_count            = 5
      max_pods             = 40
      node_labels = {
        nodepools = "default"
      }
    }
  }
}