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

# SNAT

variable "snat" {
  description = "Mappa delle regole SNAT da creare"
  type = map(object({
    name = string
    description = string
    external_address = string
    internal_address = string
    snat_destination_address = optional(string)
    priority = optional(number)
  }))
}



