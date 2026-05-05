# // Subscription Details
# # End of Subscription Details

// Variables for Azure Services
org_name       = "int"
env_name       = "prod"
region_code    = "cin"
cloud_provider = "az"
client_name    = "pf"
location       = "central india"
tags = {
  Environment = "Development"
  Owner       = "Terraform"
}
resource_group_enabled = true
// End of Variables for Azure Services
// Variables for Azure Virtual Network
virtual_network_enabled = true
vnet_address_space      = ["10.1.0.0/20"]
// End Of Variables for Azure Virtual Network
// Variables for Azure Key Vault
key_vault_enabled = true
sku_name          = "standard"
// End of Variables for Azure Key Vault
// Variables for key vault secrets
key_vault_secret_enabled = true
key_vault_secrets = {
  "int-01" = {
    secret_name  = "int-01-secret"
    secret_value = "int-01-secret-value"
  }
}
# End of Variables for key vault secrets
# Azure Storage Account Configuration
storage_account_enabled       = true
storage_account_name          = "intprodusazpf"
account_tier                  = "Standard"
account_replication_type      = "LRS"
public_network_access_enabled = true
# End Of Azure Storage Account Configuration

# Azure Virtual Machine Linux Configurations
vm_enabled               = true
lin_admin_username       = "sysadmin"
lin_vm_size              = "Standard_D2as_v5"
lin_storage_account_type = "StandardSSD_LRS"
lin_os_disk_size         = 128
lin_security_rules = {
  "ssh" = {
    name                       = "SSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
lin_publisher        = "Canonical"
lin_offer            = "0001-com-ubuntu-server-jammy"
lin_image_sku        = "22_04-lts-gen2"
lin_version          = "latest"
subnet_address_space = "10.1.0.0/26"
# End Of Virtual Machine Linux Configurations
# Azure Front Door Configuration
pvt_dns_enable = true