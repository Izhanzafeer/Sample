resource "azurerm_subnet" "vpn_subnet" {
  name                 = "GatewaySubnet"
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.vpngw_subnet_address_space]
  resource_group_name  = var.resource_group_name
}

module "virtual_network_gateway_pip" {
  source              = "../04-Public_IP"  
  public_ip_name      = upper("pip-${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}-vgw")
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}


resource "azurerm_virtual_network_gateway" "vpngw" {
  name                = upper("vgw-${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}")
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = var.vpngw_type
  vpn_type            = var.vpngw_vpn_type
  active_active       = var.vpngw_active_active
  enable_bgp          = var.vpngw_bgp
  sku                 = var.vpngw_sku
  generation          = var.vpngw_generation
  ip_configuration {
    name                          = "GatewayConfig${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}-vgw"
    public_ip_address_id          = module.virtual_network_gateway_pip.pip_id_out
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vpn_subnet.id
  }
  tags       = var.tags
  depends_on = [module.virtual_network_gateway_pip]
}
