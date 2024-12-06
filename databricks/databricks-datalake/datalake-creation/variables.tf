variable "resource_group" {
  description = "Resource group name"
  default = "RG_default"
  type        = string
}

variable "location" {
  description = "Resource group name"
  default = "francecentral"
  type        = string
}

variable "datalakegen2" {
  description = "datalake gen 2 name"
  default = "Datalake-default-name"
  type        = string
}

variable "adlsgen2" {
  default = "adls-container-default-name"
  type        = string
}

variable "sp_client_id" {
default = "defaut-sp_client_id"
type = string
}

variable "role_for_sp" {
default = "defaut-role_for_sp"
type = string
}