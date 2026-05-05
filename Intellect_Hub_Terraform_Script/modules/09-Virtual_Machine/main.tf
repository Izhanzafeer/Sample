terraform {
  required_version = ">=0.12"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}



resource "random_pet" "ssh_key_name" {
  prefix    = "ssh"
  separator = ""
}

resource "azapi_resource_action" "ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}


resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = random_pet.ssh_key_name.id
  location  = var.location
  parent_id = var.resource_group_id
}


output "key_data" {
  value = azapi_resource_action.ssh_public_key_gen.output.publicKey
}

module "virtual_machine_pip" {
  source              = "../04-Public_IP"  
  public_ip_name      = upper("pip-${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}-vm")
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

module "virtual_machine_subnet" {
  source = "../03-Subnets"
  subnet_name          = upper("snet-${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}-vm")
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  subnet_address_space = var.subnet_address_space 
}

resource "azurerm_network_security_group" "nsg" {
  name                = upper("nsg-${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}")
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
resource "azurerm_network_security_rule" "nsg_rule" {
  for_each                    = var.security_rules
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
  depends_on                  = [azurerm_network_security_group.nsg, module.virtual_machine_pip, module.virtual_machine_subnet]
}

resource "azurerm_network_interface" "nic" {
  name                = upper("nic-${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}")
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "ipconfig${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}"
    subnet_id                     = module.virtual_machine_subnet.subnet_id_out
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = module.virtual_machine_pip.pip_id_out
  }
  depends_on = [ azurerm_network_security_group.nsg, module.virtual_machine_pip, module.virtual_machine_subnet ]
}

resource "azurerm_network_interface_security_group_association" "security_group" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "windows_linux_machine" {
  name                              = upper("vm-${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}")
  computer_name                     = upper("${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}")
  admin_username                    = var.admin_username
  location                          = var.location
  resource_group_name               = var.resource_group_name
  network_interface_ids             = [azurerm_network_interface.nic.id]
  size                              = var.vm_size

  admin_ssh_key {
    username   = var.admin_username
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }

  os_disk {
    name                 = "vm-${var.org_name}-${var.env_name}-${var.region_code}-${var.client_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
    disk_size_gb         = var.disk_size
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.os_version
  }

  tags = var.tags
}

