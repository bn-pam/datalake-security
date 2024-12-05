# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = ">= 0.9.0"
    }
  }
  required_version = ">= 0.14.9"
}

# Configure the Azure provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "databricks" {
  host  = "${azurerm_databricks_workspace.databricks_workspace.workspace_url}"  # L'URL de ton Databricks Workspace
  azure_client_id     = var.sp_client_id
  azure_client_secret = var.sp_db_secret
  azure_tenant_id     = var.azure_tenant_id
}

# récupération des données du groupe de ressources azure
data "azurerm_resource_group" "current" {
  name     = var.resource_group_name
}

## optionnel : récupère mes informations une fois loggué avec "az login" via terminal
data "azurerm_client_config" "current" {}

# Création du workspace Databricks
resource "azurerm_databricks_workspace" "databricks_workspace" {
  name                = var.workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  managed_resource_group_name = var.managed_resource_group_name

  tags = {
    environment = "production"
  }
}

# resource "azurerm_role_assignment" "role_assignment" {
#   scope                = azurerm_storage_account.id
#   role_definition_name = var.role_definition_name
#   principal_id         = azurerm_databricks_workspace.identity[0].principal_id
# }

resource "databricks_cluster" "cluster-databricks" {
  cluster_name            = var.cluster_name
  spark_version = "7.3.x-scala2.12"
  node_type_id            = "Standard_DS3_v2"
  spark_conf = {
    "spark.databricks.cluster.profile" = "singleNode"
  }
  autotermination_minutes = 60
  num_workers             = 1
}

output "cluster_url" {
  value = "https://${azurerm_databricks_workspace.databricks_workspace.name}.azuredatabricks.net#cluster/${databricks_cluster.cluster-databricks.id}"
}

output "workspace_url" {
  value = azurerm_databricks_workspace.databricks_workspace.workspace_url
  }