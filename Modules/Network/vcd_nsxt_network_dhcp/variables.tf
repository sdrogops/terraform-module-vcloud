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

#-------------------------------------------------------------------------------------------------------------------------------

# NETWORK DHCP POOLS

variable "dhcp_pools" {
  description = "Mappa delle configurazioni DHCP per le reti"
  type = map(object({
    org_network_name = string
    start_address    = string
    end_address      = string
    dns_servers      = optional(list(string))
  }))
}

#-------------------------------------------------------------------------------------------------------------------------------

# NETWORK

variable "networks_ids" {
  description = "Output delle reti create, mappa nome => id"
  type        = map(string)
}