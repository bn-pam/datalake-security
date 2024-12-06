# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}
provider "azurerm" {
  features {}
}

# Compte de stockage avec Data Lake Gen2 activé
resource "azurerm_storage_account" "datalake" {
  name                     = var.datalakegen2
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true  # Activer le namespace hiérarchique pour Gen2

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }
}

# Conteneur pour le compte de stockage (où ranger les fichiers)
resource "azurerm_storage_container" "datalake_container" {
  name                  = var.adlsgen2
  container_access_type = "private"
}

# Attribution de rôle : Storage Blob Data Contributor
resource "azurerm_role_assignment" "storage_blob_contributor" {
  scope                = azurerm_storage_account.datalake.id
  role_definition_name = var.role_for_sp
  principal_id         = var.sp_client_id # ID du service principal (ici l'app DB-workspace)
}