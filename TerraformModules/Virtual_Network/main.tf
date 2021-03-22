
#resource "null_resource" "dependency_modules" {
#  provisioner "local-exec" {
#    command = "echo ${length(var.dependencies)}"
#  }
#}


resource "azurerm_virtual_network" "this" {
    name                  = var.virtual_network_name
    location              = var.location
    resource_group_name   = var.resource_group_name
    address_space         = var.vnet_address_space
    dns_servers           = var.dns_servers
    vm_protection_enabled = var.vm_protection_enabled
    tags                  = var.tags


    dynamic "ddos_protection_plan" {
        for_each = var.ddos_protection_plan
        content {
            id  = lookup(ddos_protection_plan.value, "id", null)
            enable = lookup(ddos_protection_plan.value, "enable", false)
        }
  }

#  depends_on = [null_resource.dependency_modules]
}

#resource "null_resource" "dependency_vnet" {
#  depends_on = [azurerm_virtual_network.this]
#}