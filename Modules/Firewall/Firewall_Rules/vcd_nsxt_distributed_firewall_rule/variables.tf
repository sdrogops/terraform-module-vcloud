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

#-------------------------------------------------------------------------------------------------------------------------------#

# DISTRIBUTED FIREWALL RULES

variable "distributed_firewall_rules" {
  description = "Mappa delle regole firewall"
  type = map(object({
    name                 = string
    action               = string
    source_ids           = optional(list(string))
    destination_ids      = optional(list(string))
    app_port_profile_ids = optional(list(string))
    enabled              = bool

    # campi opzionali: chi non li passa non vede alcuna differenza
    description = optional(string) # non mostrato in UI, leggibile via API
    comment     = optional(string) # mostrato in UI (VCD 10.3.2+)
    logging     = optional(bool)   # log degli hit sulla regola
    direction   = optional(string) # IN | OUT | IN_OUT (default IN_OUT)
    ip_protocol = optional(string) # IPV4 | IPV6 | IPV4_IPV6
  }))
}

variable "above_rule_id" {
  description = <<-EOT
    ID di una regola esistente sopra la quale inserire tutte le regole di
    questo modulo. Senza questo valore le regole nascono in FONDO alla policy,
    quindi sotto la default rule del VDC Group: se la default e' in DROP le
    regole non vengono mai valutate.
  EOT
  type        = string
  default     = null
}

#-------------------------------------------------------------------------------------------------------------------------------#

# IP SETS

variable "ip_sets_ids" {
  description = "Mappa nome_ip_set => ID"
  type        = map(string)
}

#-------------------------------------------------------------------------------------------------------------------------------#

# APP PORT PROFILES

variable "app_port_profiles_ids" {
  description = "Mappa nome_app_port_profile => ID"
  type        = map(string)
}