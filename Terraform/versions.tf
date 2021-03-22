provider "azurerm" {
  # Whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version         = "2.42.0"
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  features {}
}

terraform {
  required_version = "0.14.4"
#  backend "azurerm" {} # Backend variables are initialized through the secret and variable folders
}