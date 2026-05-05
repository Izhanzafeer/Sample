data "azurerm_virtual_network" "existing_vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "existing_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

# Data source in hub subscription
data "azurerm_private_dns_zone" "sb_pvt_dns" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = var.hub_resource_group_name
}



resource "azurerm_servicebus_namespace" "sb" {
  name                = "SB-${upper(var.service_bus_namespace_name)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  capacity            = var.capacity
  premium_messaging_partitions = var.premium_messaging_partitions
  tags                = var.tags
}

# DNS link in hub subscription
resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  name                  = "link-${data.azurerm_virtual_network.existing_vnet.name}-sb"
  private_dns_zone_name = data.azurerm_private_dns_zone.sb_pvt_dns.name
  virtual_network_id    = data.azurerm_virtual_network.existing_vnet.id
  resource_group_name   = data.azurerm_private_dns_zone.sb_pvt_dns.resource_group_name
  tags                  = var.tags
  depends_on = [ azurerm_servicebus_namespace.sb ]
}

# Private endpoint in spoke subscription
resource "azurerm_private_endpoint" "psql_pvt_enpoint" {
  name                = "pe-${azurerm_servicebus_namespace.sb.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.existing_subnet.id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-${azurerm_servicebus_namespace.sb.name}"
    private_connection_resource_id = azurerm_servicebus_namespace.sb.id
    is_manual_connection           = false
    subresource_names              = ["namespace"]
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.sb_pvt_dns.name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.sb_pvt_dns.id]
  }
  depends_on = [ azurerm_servicebus_namespace.sb  ]
}
