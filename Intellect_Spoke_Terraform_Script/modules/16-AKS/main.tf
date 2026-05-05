# Fetch the current Azure client configuration
data "azurerm_client_config" "current" {}



module "aks_subnet" {
  source               = "../03-Subnets"
  subnet_name          = var.aks_cluster_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
  subnet_address_space = var.subnet_address_space
}

module "aks_pip" {
  source              = "../04-Public_IP"
  public_ip_name      = "${upper(var.aks_cluster_name)}-aks"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

data "azurerm_key_vault" "kv" {
  name                = "KV-${upper(var.vault_name)}"
  resource_group_name = var.resource_group_name
}

# Define Log Analytics workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = "LAW-${upper(var.log_analytics_workspace_name)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.law_sku
  tags                = var.tags
}

data "azurerm_nat_gateway" "nat" {
  name = "NG-${upper(var.nat_gateway_name)}"
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_nat_gateway_association" "aks_subnet_nat_gw_association" {
  subnet_id      = module.aks_subnet.subnet_id
  nat_gateway_id = data.azurerm_nat_gateway.nat.id
  depends_on = [ data.azurerm_nat_gateway.nat, module.aks_subnet ]
}

# Define Kubernetes cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                 = "AKS-${upper(var.aks_cluster_name)}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  dns_prefix           = var.aks_cluster_name
  node_resource_group  = var.node_resource_group # Uncomment if specifying a unique Node Resource Group
  sku_tier             = var.sku_tier
  kubernetes_version   = var.kubernetes_version
  azure_policy_enabled = var.azure_policy_enabled
  tags                 = var.tags

  network_profile {
    network_plugin    = var.network_plugin
    load_balancer_sku = "standard"
    outbound_type     = "userAssignedNATGateway"
    nat_gateway_profile {
      managed_outbound_ip_count = 1
    }
  }

  # Default node pool
  default_node_pool {
    name                 = var.nodepools["default"].name
    node_count           = var.nodepools["default"].node_count
    vm_size              = var.nodepools["default"].vm_size
    vnet_subnet_id       = module.aks_subnet.subnet_id
    os_disk_size_gb      = var.nodepools["default"].os_disk_size_gb
    max_pods             = var.nodepools["default"].max_pods
    auto_scaling_enabled = var.nodepools["default"].auto_scaling_enabled
    min_count            = var.nodepools["default"].min_count
    max_count            = var.nodepools["default"].max_count
    node_labels          = var.nodepools["default"].node_labels
    upgrade_settings {
      max_surge = "10%"
    }
  }

  identity {
    type = var.identity_type
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  lifecycle {
    ignore_changes = [
      network_profile[0].nat_gateway_profile
    ]
  }
  depends_on = [ azurerm_subnet_nat_gateway_association.aks_subnet_nat_gw_association ]
}

# Define Kubernetes cluster node pools
resource "azurerm_kubernetes_cluster_node_pool" "additional" {
  for_each = { for k, v in var.nodepools : k => v if k != "default" }

  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vnet_subnet_id        = module.aks_subnet.subnet_id
  mode                  = each.value.mode
  vm_size               = each.value.vm_size
  max_pods              = each.value.max_pods
  os_disk_size_gb       = each.value.os_disk_size_gb
  os_type               = each.value.os_type
  auto_scaling_enabled  = each.value.auto_scaling_enabled
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  tags                  = var.tags
}



resource "azurerm_key_vault_access_policy" "k8s_key_vault_mi_access" {
  key_vault_id       = data.azurerm_key_vault.kv.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].object_id
  key_permissions    = var.k8s_key_permissions
  secret_permissions = var.k8s_secret_permissions
}

resource "azurerm_monitor_action_group" "action_group" {
  name                = "AG-AKS-${upper(var.aks_cluster_name)}"
  resource_group_name = var.resource_group_name
  short_name          = "ag-aks"
  tags                = var.tags
  depends_on          = [azurerm_kubernetes_cluster.aks]

  email_receiver {
    name          = var.email_reciever_name
    email_address = var.email_reciever_id
  }
}

resource "azurerm_monitor_metric_alert" "cpu_usage_alert" {
  name                = "CPU Usage Percentage - AKS-${upper(var.aks_cluster_name)}"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_kubernetes_cluster.aks.id]
  description         = "Alert when CPU usage is greater than 95%"
  severity            = 3
  enabled             = true
  tags                = var.tags
  depends_on          = [azurerm_monitor_action_group.action_group]

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_cpu_usage_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 95
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group.id
  }
}

resource "azurerm_monitor_metric_alert" "aks_memory_alert" {
  name                = "Memory Working Set Percentage - AKS-${upper(var.aks_cluster_name)}"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_kubernetes_cluster.aks.id]
  description         = "Alert when Memory set is greater than 100%"
  severity            = 3
  enabled             = true
  depends_on          = [azurerm_monitor_action_group.action_group]
  tags                = var.tags
  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_memory_working_set_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 100
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group.id
  }
}
