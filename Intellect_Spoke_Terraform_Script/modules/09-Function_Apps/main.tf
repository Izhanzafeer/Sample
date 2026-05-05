data "azurerm_container_registry" "acr" {
  name                = "ACR${upper(var.acr_name)}"
  resource_group_name = var.resource_group_name
}

data "azurerm_virtual_network" "existing_vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "existing_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

data "azurerm_private_dns_zone" "app_pvt_dns" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = var.hub_resource_group_name
}

data "azurerm_service_plan" "asp" {
  name                = "ASP-${upper(var.app_service_plan_name)}"
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account" "stg" {
  name                = "stg${lower(var.storage_account_name)}"
  resource_group_name = var.resource_group_name
}

locals {
  is_linux = lower(var.os_type) == "linux"
}

# Linux Function App
resource "azurerm_linux_function_app" "function_app_linux" {
  count = local.is_linux ? 1 : 0

  name                       = "FUNC-${upper(var.function_app_name)}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  tags                       = var.tags
  storage_account_name       = data.azurerm_storage_account.stg.name
  storage_account_access_key = data.azurerm_storage_account.stg.primary_access_key
  service_plan_id            = data.azurerm_service_plan.asp.id
  
  identity {
    type = "SystemAssigned"
  }
  
  site_config {
    always_on = var.always_on
  }
}

# Windows Function App
resource "azurerm_windows_function_app" "function_app_windows" {
  count = local.is_linux ? 0 : 1

  name                       = "FUNC-${upper(var.function_app_name)}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  tags                       = var.tags
  storage_account_name       = data.azurerm_storage_account.stg.name
  storage_account_access_key = data.azurerm_storage_account.stg.primary_access_key
  service_plan_id            = data.azurerm_service_plan.asp.id
  
  identity {
    type = "SystemAssigned"
  }
  
  site_config {
    always_on = var.always_on
  }
}

# Role Assignment for Linux Function App
resource "azurerm_role_assignment" "rbac_linux" {
  count                = local.is_linux ? 1 : 0
  principal_id         = azurerm_linux_function_app.function_app_linux[0].identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = data.azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

# Role Assignment for Windows Function App
resource "azurerm_role_assignment" "rbac_windows" {
  count                = local.is_linux ? 0 : 1
  principal_id         = azurerm_windows_function_app.function_app_windows[0].identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = data.azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

# DNS Link in Hub Subscription
resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  name                  = "link-${data.azurerm_virtual_network.existing_vnet.name}-app"
  private_dns_zone_name = data.azurerm_private_dns_zone.app_pvt_dns.name
  virtual_network_id    = data.azurerm_virtual_network.existing_vnet.id
  resource_group_name   = data.azurerm_private_dns_zone.app_pvt_dns.resource_group_name
  tags                  = var.tags
  depends_on = [ azurerm_linux_function_app.function_app_linux , azurerm_windows_function_app.function_app_windows ]
}

# Private Endpoint for Linux Function App
resource "azurerm_private_endpoint" "psql_pvt_endpoint_linux" {
  count               = local.is_linux ? 1 : 0
  name                = "pe-${azurerm_linux_function_app.function_app_linux[0].name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.existing_subnet.id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-${azurerm_linux_function_app.function_app_linux[0].name}"
    private_connection_resource_id = azurerm_linux_function_app.function_app_linux[0].id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.app_pvt_dns.name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.app_pvt_dns.id]
  }
  depends_on = [ azurerm_linux_function_app.function_app_linux ]
}

# Private Endpoint for Windows Function App
resource "azurerm_private_endpoint" "psql_pvt_endpoint_windows" {
  count               = local.is_linux ? 0 : 1
  name                = "pe-${azurerm_windows_function_app.function_app_windows[0].name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.existing_subnet.id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-${azurerm_windows_function_app.function_app_windows[0].name}"
    private_connection_resource_id = azurerm_windows_function_app.function_app_windows[0].id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.app_pvt_dns.name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.app_pvt_dns.id]
  }
    depends_on = [ azurerm_windows_function_app.function_app_windows]

}

# Outputs
# output "function_app_id" {
#   value = local.is_linux ? azurerm_linux_function_app.function_app_linux[0].id : azurerm_windows_function_app.function_app_windows[0].id
# }

# output "function_app_name" {
#   value = local.is_linux ? azurerm_linux_function_app.function_app_linux[0].name : azurerm_windows_function_app.function_app_windows[0].name
# }

# output "function_app_principal_id" {
#   value = local.is_linux ? azurerm_linux_function_app.function_app_linux[0].identity[0].principal_id : azurerm_windows_function_app.function_app_windows[0].identity[0].principal_id
# }