# CATALOGS

output "catalogs_ids" {
  value = module.vcd_catalog.catalogs_ids
}

# ---------------------------------------------------------------------------------------------------

# CATALOG VAPP TEMPLATE

output "vapp_templates_ids" {
  value = module.vcd_catalog_vapp_template.vapp_templates_ids
}

# ---------------------------------------------------------------------------------------------------

# APP PORT PROFILES

output "app_port_profiles_ids" {
  value = module.vcd_nsxt_app_port_profile.app_port_profiles_ids
}

# ---------------------------------------------------------------------------------------------------

# IP SETS

output "ip_sets_ids" {
  value = module.vcd_nsxt_ip_set.ip_sets_ids
}

# ---------------------------------------------------------------------------------------------------

# IP SETS

output "networks_ids" {
  value = module.vcd_network_routed_v2.networks_ids
}

# ---------------------------------------------------------------------------------------------------

# VM

output "vm_networks" {
  description = "Informazioni di rete (MAC/IP/Network) delle VM create"
  value       = module.vcd_vm.vm_networks
}
