# -
# - Create Resource Group
# -
resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}


module "azure_vnet" {
    source = "../TerraformModules/Virtual_Network"
    virtual_network_name = var.virtual_network_name
    location             = var.location
    resource_group_name  = azurerm_resource_group.this.name
    vnet_address_space   = var.vnet_address_space
#    dependencies         = [module.key_vault.depended_on_kv]
}


#module "key_vault" {
#  source = "../TerraformModules/Keyvault"
#  name                        = var.keyvault_name
#  enabled_for_disk_encryption = var.enabled_for_disk_encryption
#  purge_protection_enabled    = var.purge_protection_enabled
#  resource_group_name         = azurerm_resource_group.this.name
#  dependencies                = [azurerm_resource_group.this]
#}

module "kubernetes_cluster" {
  source                      = "../TerraformModules/AKS"
  name                        = var.aks_name
  resource_group_name  = azurerm_resource_group.this.name
  nodecount                   = var.nodecount
  nodesize                    = var.nodesize
  dns_prefix                  = var.dns_prefix
  identity_type               = var.identity_type
  enable_role_based_access_control = var.enable_role_based_access_control
  rbac_aad_managed            = var.rbac_aad_managed
  rbac_aad_admin_group_object_ids = var.rbac_aad_admin_group_object_ids
  depends_on         = [module.azure_vnet]
}