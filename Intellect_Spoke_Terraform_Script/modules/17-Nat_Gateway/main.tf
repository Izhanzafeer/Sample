module "nat_subnet" {
  source               = "../03-Subnets"
  subnet_name          = "var.nat_gateway_name"
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
  subnet_address_space = var.subnet_address_space
}

module "nat_gateway_pip" {
  source              = "../04-Public_IP"
  public_ip_name      = "${upper(var.nat_gateway_name)}-ng"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway" "nat" {
  name                    = "NG-${upper(var.nat_gateway_name)}"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = var.sku
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  tags                    = var.tags
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gw_association" {
  subnet_id      = module.nat_subnet.subnet_id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}

resource "azurerm_nat_gateway_public_ip_association" "nat_to_pip" {
  nat_gateway_id       = azurerm_nat_gateway.nat.id
  public_ip_address_id = module.nat_gateway_pip.pip_id_out
}