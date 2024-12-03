
# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}

## optionnel : récupère mes informations une fois loggué avec "az login" via terminal
data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "current" {
  name = var.resource_group_name
}
data "azurerm_key_vault" "current" {
  resource_group_name = var.resource_group_name
  name = var.keyvault_name
} 

data "azurerm_key_vault_secret" "current" {
  name         = var.secret_name
  key_vault_id = data.azurerm_key_vault.current.id
}

# locals {
#   # Récupérer le nom du Resource Group (issu de la data source)
#   location = try(data.azurerm_resource_group.current.location, var.location)
#   secret_name = try(data.azurerm_key_vault_secret.current.name, var.secret_name)
#   secret_value = try(data.azurerm_key_vault_secret.current.value, var.secret_value)
#   secret_id =  try(data.azurerm_key_vault_secret.current.id, var.secret_id)
#   tenant_id       = try(data.azurerm_client_config.current.tenant_id, var.tenant_id)
#   subscription_id = try(data.azurerm_client_config.current.subscription_id, var.subscription_id)
# }

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
   }

# Création du Key Vault dans le groupe de ressources existant
resource "azurerm_key_vault" "keyvault" {
  name                        = var.keyvault_name
  location                    = try(data.azurerm_resource_group.current.location, var.location)
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  sku_name = var.sku_name  # Ajoute le SKU ici
  tenant_id = try(data.azurerm_client_config.current.tenant_id, var.tenant_id)  # Utilise le tenant_id via une variable locale
}

# Création d'un secret dans le Key Vault
resource "azurerm_key_vault_secret" "example" {
  name         = try(data.azurerm_key_vault_secret.current.name, var.secret_name)
  value        = try(data.azurerm_key_vault_secret.current.value, var.secret_value)
  key_vault_id = try(data.azurerm_key_vault_secret.current.id, var.secret_id)
}