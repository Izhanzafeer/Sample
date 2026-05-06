# terraform {
#   backend "azurerm" {
#     resource_group_name  = "Izhan-RG"
#     storage_account_name = "tfstatessrivas"
#     container_name       = "tfstate-hub"
#     key                  = "hub.terraform.tfstate"
#   }
# }