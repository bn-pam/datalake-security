variable "subscription_id" {
  description = "Nom du subscription_id d'azure"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string
  default = "Azure-RG"
}

variable "db_resource_group_name" {
  description = "The name of the databricks resource group"
  type        = string
  default = "Azure-DB-RG"
}

variable "location" {
  description = "The Azure region for the resources"
  type        = string
  default     = "France Central"  # Par défaut, si non spécifié
}

variable "workspace_name" {
  description = "Nom du workspace Databricks."
  type        = string
  default = "default_workspace-db"
}

variable "sku" {
  description = "Niveau de tarification du workspace Databricks."
  type        = string
  default     = "standard" # Options : standard, premium, trial
}

variable "managed_resource_group_name" {
  description = "Nom du groupe de ressources géré automatiquement par Azure Databricks."
  type        = string
  default = "default_managed-rg-db-exemple"
}

variable "env_name" {
  description = "Nom de l'environnement pour databricks"
  type = string
  default = "default-env_db_example"
}

variable "cluster_name" {
  description = "ID du cluster de databricks"
  type = string
  default = "cdefault-cluster-db-name"
}

variable "azurerm_role_assignment"{
  description = "Role Assignment for Azure DB"
  type = string
  default = "default-role_assignement"
}

variable "role_definition_name"{
  description = "Role Assignment type for Azure DB"
  type = string
  default = "default-role_definition_name"
}

variable "azure_tenant_id"{
  description = "tenant id for Azure DB"
  type = string
  default = "default-tenant_id"
}

variable "sp_db_secret"{
  description = "sp secret for Azure DB"
  type = string
  default = "default-sp_db_secret"
}

variable "sp_client_id"{
  description = "sp secret for Azure DB"
  type = string
  default = "default-sp_client_id"
}

