# Backend Configuration for Hub Terraform State File
# This configures Azure Storage as the remote backend for Terraform state

terraform {
  backend "azurerm" {
    # Backend configuration for Hub state file
    # Uncomment and configure these values, or pass via -backend-config during terraform init
    resource_group_name  = "srinivasan-rg"
    storage_account_name = "tfstatessrivas"
    container_name       = "tfstate-hub"
    key                  = "hub.terraform.tfstate"
  }
}