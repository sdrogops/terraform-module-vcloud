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

# IPSEC

variable "ipsec" {
  description = "Mappa dei tunnel IPsec VPN"
  type = map(object({
    name               = string
    description        = string
    pre_shared_key     = string
    local_ip_address   = string
    local_networks     = list(string)
    remote_ip_address  = string
    remote_networks    = list(string)

    security_profile = object({
      ike_version                  = string
      ike_encryption_algorithms    = list(string)
      ike_digest_algorithms        = list(string)
      ike_dh_groups                = list(string)
      ike_sa_lifetime              = number

      tunnel_pfs_enabled           = bool
      tunnel_df_policy             = string
      tunnel_encryption_algorithms = list(string)
      tunnel_digest_algorithms     = list(string)
      tunnel_dh_groups             = list(string)
      tunnel_sa_lifetime           = number

      dpd_probe_internal           = number
    })
  }))
}