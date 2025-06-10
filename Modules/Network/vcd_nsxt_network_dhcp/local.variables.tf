locals {
  dhcp_pools = {
    for k, v in var.dhcp_pools : k => {
      org_network_id = var.networks_ids[v.org_network_name]
      start_address  = v.start_address
      end_address    = v.end_address
    }
  }
}