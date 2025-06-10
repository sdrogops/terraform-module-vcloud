variable "vcd_org" {
  description = "vCloud Org"
  type        = string
}

variable "vcd_vdc" {
  description = "vCloud Virtual Datacenter"
  type        = string
}

variable "vcd_auth_type" {
  description = "Tipo di autenticazione"
  type        = string
}

variable "vcd_token" {
  description = "Token API"
  type        = string
  sensitive   = true
}

variable "vcd_api_version" {
  description = "Versione API"
  type        = string
}

variable "vcd_allow_unverified_ssl" {
  description = "Permette SSL non verificato"
  type        = bool
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

#-------------------------------------------------------------------------------------------------------------------------------

# NETWORKS

variable "vm_networks" {
  description = "Output del modulo vcd_vm contenente informazioni su vm_id e vapp_name"
  type = map(object({
    vm_id     = string
    vm_name   = string
    vapp_name = string
    networks  = map(any) # Non serve il dettaglio dei network qui
  }))
}
