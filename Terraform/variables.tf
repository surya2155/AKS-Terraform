## global vars
variable "location" {}
variable "resource_group_name" {}
#variable "common_tags" {}

## local vars
variable "virtual_network_name" {}
variable "vnet_address_space" {}

variable "tenant_id" {
  description = "Azure tenant Id."
}

variable "subscription_id" {
  description = "Azure subscription Id."
}

variable "client_id" {
  description = "Azure service principal application Id"
}

variable "client_secret" {
  description = "Azure service principal application Secret"
}

variable "client_id_aks" {
  description = "Azure service principal application Id"
  default     = ""
}

variable "client_secret_aks" {
  description = "Azure service principal application Secret"
  default     = ""
}

variable "keyvault_name" {}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "Allow Soft Delete be enabled for this Key Vault"
  default     = false
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Allow purge_protection be enabled for this Key Vault"
  default     = true
}

variable "aks_name" {}

variable "dns_prefix" {}

variable "nodecount" {}

variable "nodesize" {}

variable "identity_type" {
  description = "identity_type for AKS"
  type        = string
  default     = "service_principal"
}

variable "enable_role_based_access_control" {
  description = "Enable Role Based Access Control."
  type        = bool
  default     = false
}

variable "rbac_aad_managed" {
  description = "Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration."
  type        = bool
  default     = false
}

variable "rbac_aad_admin_group_object_ids" {
  description = "Object ID of groups with admin access."
  type        = list(string)
  default     = null
}