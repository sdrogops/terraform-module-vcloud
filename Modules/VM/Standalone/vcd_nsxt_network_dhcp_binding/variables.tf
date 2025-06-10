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

# DHCP Bindings

variable "dhcp_bindings" {
  type = map(object({
    name        = string
    description = string
    vm_name     = string
    network     = string
    ip_address  = string
    dns_servers = list(string)
  }))
}

#-------------------------------------------------------------------------------------------------------------------------------

# NETWORK

variable "network_ids" {
  type = map(string)
  description = "Mappa dei nomi rete -> ID rete"
}

#-------------------------------------------------------------------------------------------------------------------------------

# VM

variable "vm_networks" {
  type = map(object({
    vm_id   = string
    networks = map(object({
      mac_address = string
    }))
  }))
  description = "Output delle VM contenente i mac per ogni rete"
}

