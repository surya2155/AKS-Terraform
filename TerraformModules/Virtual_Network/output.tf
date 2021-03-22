## Virtual network outputs

output "az_virtual_network_id" {
  description = "The id of the virtual network"
  value       = azurerm_virtual_network.this.id
}

output "az_virtual_network_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.this.name
}

output "az_virtual_network_address_space" {
  description = "List of address spaces that are used the virtual network."
  value       = azurerm_virtual_network.this.address_space
}

#output "depended_on_vnet" {
#  value = null_resource.dependency_vnet.id
#}