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

# VM

variable "vm" {
  type = map(object({
    name                 = string
    computer_name        = string
    vapp_template_name   = string
    cpus                 = number
    memory               = number
    network              = list(string)
    disk_size            = number
  }))
}

#-------------------------------------------------------------------------------------------------------------------------------

# CATALOG

variable "catalogs_ids" {
  description = "Mappa nome_catalogo => catalog_id"
  type        = map(string)
}

#-------------------------------------------------------------------------------------------------------------------------------

# CATALOG VAPP TEMPLATE

variable "vapp_templates_ids" {
  description = "Mappa nome_template => template_id"
  type        = map(string)
}

#-------------------------------------------------------------------------------------------------------------------------------

variable "networks_ids" {
  description = "Mappa nome rete → ID"
  type        = map(string)
}