# PROVIDER

variable "vcd_auth_type" {
  description = "Tipo di autenticazione da usare."
  type        = string
}

variable "vcd_token" {
  description = "Token API per autenticazione."
  type        = string
  sensitive   = true
}

variable "vcd_vdc" {
  description = "Nome del Virtual Data Center."
  type        = string
}

variable "vcd_api_version" {
  description = "Versione dell'API vCD da usare."
  type        = string
}

variable "vcd_allow_unverified_ssl" {
  description = "Permette connessioni SSL non verificate."
  type        = bool
}

variable "vcd_org" {
    description = "vCloud Org"
    type           = string
}

variable "vcd_edge_gateway" {
    description = "vCloud Edge Gateway Name"
    type           = string
}

variable "vcd_vdc_group" {
    description = "vCloud Datacenter Group Name"
    type           = string
}

#-------------------------------------------------------------------------------------------------------------------------------#

# DNAT

variable "dnat" {
  description = "Mappa delle regole DNAT da creare"
  type = map(object({
    name = string
    description = string
    external_address = string
    internal_address = string
    dnat_external_port = optional(number)
    app_port_profile_id = optional(string)
    priority         = optional(number)
  }))
}

#-------------------------------------------------------------------------------------------------------------------------------#

# APP PORT PROFILES

variable "app_port_profiles_ids" {
  description = "Mappa nome_app_port_profile => ID"
  type        = map(string)
}