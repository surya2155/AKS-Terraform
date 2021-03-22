data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "example" {
  name                            = var.name
  location                        = data.azurerm_resource_group.this.location
  resource_group_name             = data.azurerm_resource_group.this.name
  dns_prefix                      = var.dns_prefix
  kubernetes_version              = var.kubernetes_version
  private_cluster_enabled         = var.private_cluster_enabled
  node_resource_group             = var.node_resource_group

  default_node_pool {
    name       = "default"
    node_count = var.nodecount
    vm_size    = var.nodesize
  }

  dynamic "service_principal" {
    for_each = var.client_id_aks != "" && var.client_secret_aks != "" ? ["service_principal"] : []
    content {
        client_id = var.client_id
        client_secret = var.client_secret
    }
  }

  dynamic "identity" {
    for_each = var.client_id_aks == "" || var.client_secret_aks == "" ? ["identity"] : []
    content {
        type = "SystemAssigned"
    }
  }

  # active directory config block
  role_based_access_control {
    enabled = var.enable_role_based_access_control

    dynamic "azure_active_directory" {
      for_each = var.enable_role_based_access_control && var.rbac_aad_managed ? ["rbac"] : []
      content {
        managed                = true
        admin_group_object_ids = var.rbac_aad_admin_group_object_ids
      }
    }

    dynamic "azure_active_directory" {
      for_each = var.enable_role_based_access_control && !var.rbac_aad_managed ? ["rbac"] : []
      content {
        managed           = false
        client_app_id     = var.rbac_aad_client_app_id
        server_app_id     = var.rbac_aad_server_app_id
        server_app_secret = var.rbac_aad_server_app_secret
      }
    }
  }

  # network_profile config block
  dynamic "network_profile" {
    for_each = var.network_profile
    content {
      network_plugin     = lookup(network_profile.value, "network_plugin", null)
      network_policy     = lookup(network_profile.value, "network_policy", null)
      dns_service_ip     = lookup(network_profile.value, "dns_service_ip", null)
      docker_bridge_cidr = lookup(network_profile.value, "docker_bridge_cidr", null)
      outbound_type      = lookup(network_profile.value, "outbound_type", null)
      pod_cidr           = lookup(network_profile.value, "pod_cidr", null)
      service_cidr       = lookup(network_profile.value, "service_cidr", null)
    }
  }

  tags = {
    Environment = "test"
  }
}

