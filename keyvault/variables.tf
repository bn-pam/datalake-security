variable "tenant_id" {
  description = "The Azure Tenant ID"
  type        = string
  default     = ""  # Valeur vide par défaut, à remplir si nécessaire
}

variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
  default     = ""  # Valeur vide par défaut, à remplir si nécessaire
}

variable "keyvault_name" {
  description = "The name of the Azure Key Vault"
  type        = string
  default     = "my-unique-keyvault-name"  # Valeur par défaut
}

variable "resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string
  default = "my-unique-resource-group-name"
}

variable "location" {
  description = "The Azure region for the resources"
  type        = string
  default     = "France Central"  # Par défaut, si non spécifié
}

variable "sku_name" {
  description = "The SKU name for the Azure Key Vault"
  type        = string
  default     = "standard"
}

variable "secret_name" {
  description = "The name of the secret to store in the Key Vault"
  type        = string
  default = ""
}

variable "secret_value" {
  description = "The value of the secret to store in the Key Vault"
  type        = string
  default = "defaultsecretvalue"
}

variable "secret_id" {
  description = "The ID of the secret to store in the Key Vault"
  type        = string
  default = "defaultsecretid"
}