variable "tenant_id" {
  description = "The Azure Tenant ID"
  type        = string
  default     = ""  # Valeur vide par défaut, à remplir si nécessaire
}

variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
  default     = "029b3537-0f24-400b-b624-6058a145efe1"  # Valeur vide par défaut, à remplir si nécessaire
}

variable "keyvault_name" {
  description = "The name of the Azure Key Vault"
  type        = string
  default     = "my-unique-keyvault-name"  # Valeur par défaut
}

variable "resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string
  default = "RG_PBONNEAU"
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
  default = "defaultsecretname"
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




# variable "resource_group_name" {
#   default = "RG_PBONNEAU"
#   type        = string
# }

# variable "sku_name" {
#   default = "standard"
#   type        = string
# }

# variable "tenant_id" {
#   default = "pbo-tenant"
#   type        = string
# }

# variable "key_vault_id" {
#   description = "/subscriptions/029b3537-0f24-400b-b624-6058a145efe1/resourceGroups/RG_PBONNEAU/providers/Microsoft.KeyVault/vaults/"
#   type        = string

# # condition regex pour valider mon keyvault id
#   validation {
#     condition     = can(regex("^/subscriptions/.*/resourceGroups/.*/providers/Microsoft.KeyVault/vaults/.*$", var.key_vault_id))
#     error_message = "The keyvault_id must be a valid Azure Key Vault ID."
#   }
# }

# variable "subscription_id" {
# default =  "029b3537-0f24-400b-b624-6058a145efe1"
# type = string
# }

