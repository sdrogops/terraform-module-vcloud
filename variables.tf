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

#-------------------------------------------------------------------------------------------------------------------------------

# CATALOG VAPP TEMPLATE

variable "catalog_vapp_template" {
  description = "Mappa dei vApp template da creare nei cataloghi."
  type = map(object({
    name               = string
    description        = string
    ova_path           = string
    catalog_name       = string
    upload_piece_size  = number
  }))
}

#-------------------------------------------------------------------------------------------------------------------------------#

# APP PORT PROFILES

variable "app_port_profiles" {
  description = "Mappa degli App Port Profile da creare"
  type = map(object({
    name        = string
    description = string
    scope       = string
    protocol    = string
    port        = list(number)
  }))
}

#-------------------------------------------------------------------------------------------------------------------------------#

# IP SETS

variable "ip_sets" {
  description = "Mappa degli IP Set da creare"
  type        = map(object({
    name = string
    description = string
    ip_addresses = list(string)
  }))
}

#-------------------------------------------------------------------------------------------------------------------------------#

# DISTRIBUTED FIREWALL RULES

variable "distributed_firewall_rules" {
  description = "Mappa delle regole firewall"
  type = map(object({
    name            = string
    action          = string
    source_ids      = optional(list(string))
    destination_ids = optional(list(string))
    app_port_profile_ids = optional(list(string))
    enabled         = bool
  }))
}

#-------------------------------------------------------------------------------------------------------------------------------#

# FIREWALL RULES

variable "firewall_rules" {
  description = "Mappa delle regole firewall"
  type = map(object({
    name            = string
    action          = string
    direction       = string
    source_ids      = optional(list(string))
    destination_ids = optional(list(string))
    app_port_profile_ids = optional(list(string))
    enabled         = bool
  }))
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

# NO_SNAT

variable "no_snat" {
  description = "Mappa delle regole NO_SNAT da creare"
  type = map(object({
    name = string
    description = string
    internal_address = string
    snat_destination_address = optional(string)
    priority = optional(number)
  }))
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

#-------------------------------------------------------------------------------------------------------------------------------#

# # IPSEC

# variable "ipsec" {
#   description = "Mappa dei tunnel IPsec VPN"
#   type = map(object({
#     name               = string
#     description        = string
#     pre_shared_key     = string
#     local_ip_address   = string
#     local_networks     = list(string)
#     remote_ip_address  = string
#     remote_networks    = list(string)

#     security_profile = object({
#       ike_version                  = string
#       ike_encryption_algorithms    = list(string)
#       ike_digest_algorithms        = list(string)
#       ike_dh_groups                = list(string)
#       ike_sa_lifetime              = number

#       tunnel_pfs_enabled           = bool
#       tunnel_df_policy             = string
#       tunnel_encryption_algorithms = list(string)
#       tunnel_digest_algorithms     = list(string)
#       tunnel_dh_groups             = list(string)
#       tunnel_sa_lifetime           = number

#       dpd_probe_internal           = number
#     })
#   }))
# }

#-------------------------------------------------------------------------------------------------------------------------------

# NETWORK

variable "networks" {
  description = "Mappa delle reti da creare"
  type = map(object({
    name          = string
    description   = string
    gateway       = string
    prefix_length = number
    dns1          = string
    dns2          = optional(string)
  }))
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

# VM DISKS

variable "disks" {
  description = "Dischi interni da assegnare alle VM"
  type = map(object({
    vm_name         = string
    bus_number      = number
    unit_number     = number
    size_in_gb      = number
    storage_profile = string
  }))
}