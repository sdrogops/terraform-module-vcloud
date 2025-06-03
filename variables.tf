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

variable "vcd_url" {
  description = "URL del server vCD."
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
  type        = string
}

variable "vcd_edge_gateway" {
  description = "vCloud Edge Gateway Name"
  type        = string
}

variable "vcd_vdc_group" {
  description = "vCloud Datacenter Group Name"
  type        = string
}

#-------------------------------------------------------------------------------------------------------------------------------

# CATALOG

variable "catalog" {
  description = "Mappa dei cataloghi da creare."
  type = map(object({
    name        = string
    description = string
  }))
}

variable "vcd_catalog_delete_recursive" {
  description = "Elimina ricorsivamente il contenuto del catalogo."
  type        = bool
}

variable "vcd_catalog_delete_force" {
  description = "Forza l'eliminazione del catalogo ignorando errori."
  type        = bool
}

variable "vcd_catalog_publish_enabled" {
  description = "Rende il catalogo pubblicabile ad altri org."
  type        = bool
}

variable "vcd_catalog_preserve_identity_information" {
  description = "Preserva le informazioni di identità dei vApp template."
  type        = bool
}

variable "vcd_catalog_cache_enabled" {
  description = "Abilita la cache per i vApp template nel catalogo."
  type        = bool
}

#-------------------------------------------------------------------------------------------------------------------------------

# CATALOG VAPP TEMPLATE

variable "catalog_vapp_template" {
  description = "Mappa dei vApp template da creare nei cataloghi."
  type = map(object({
    name              = string
    description       = string
    ova_path          = string
    catalog_name      = string
    upload_piece_size = number
  }))
}

