output "key_vault_id" {
  description = "The Id of the Key Vault"
  value       = azurerm_key_vault.example.id
}

output "key_vault_name" {
  description = "The Name of the Key Vault"
  value       = azurerm_key_vault.example.name
}

output "depended_on_kv" {
  value = null_resource.dependency_kv.id
}