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

#récupère les infos du resource group, sur la base de son nom
data "azurerm_resource_group" "current" {
  name = var.resource_group_name
}

#récupère les infos du keyvault de mon resource group
data "azurerm_key_vault" "current" {
  resource_group_name = var.resource_group_name
  name = var.keyvault_name
} 

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
   }

# Création du Key Vault dans le groupe de ressources existant
resource "azurerm_key_vault" "keyvault" {
  count         = length(data.azurerm_key_vault.current) > 0 ? 0 : 1 # vérifie si un keyvault est déjà présent pour continuer la création
  name                        = var.keyvault_name
  location                    = try(data.azurerm_resource_group.current.location, var.location) # Utilise la location via les infos récupérées dans client_config, ou bien va chercher celles du fichier de variables
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  sku_name = var.sku_name  # Ajoute le SKU ici
  tenant_id = try(data.azurerm_client_config.current.tenant_id, var.tenant_id)  # Utilise le tenant_id via les infos récupérées dans client_config, ou bien va chercher celles du fichier de variables
}

# Création d'un secret dans le Key Vault s'il n'est pas déjà présent 
resource "azurerm_key_vault_secret" "example" {
  # count        = try(data.azurerm_key_vault_secret.current.name, "")  == var.secret_name ? 0 : 1 # vérifie si un secret avec le même nom est déjà présent pour stopper la création
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = data.azurerm_key_vault.current.id
}