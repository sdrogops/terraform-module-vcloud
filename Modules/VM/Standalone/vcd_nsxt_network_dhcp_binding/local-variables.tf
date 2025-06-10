locals {
  binding_type = "IPV4"
  lease_time   = 3600

  networks_by_name = var.network_ids

  mac_by_vm_and_net = {
    for vm_name, vm_data in var.vm_networks :
    vm_name => {
      for net_name, net_data in vm_data.networks :
      net_name => {
        mac_address = net_data.mac_address
      }
    }
  }

  dhcp_bindings = {
    for k, v in var.dhcp_bindings : k => {
      org_network_id = local.networks_by_name[v.network]
      mac_address    = local.mac_by_vm_and_net[v.vm_name][v.network].mac_address
      ip_address     = v.ip_address
      dns_servers    = v.dns_servers
      name           = v.name
      description    = v.description
    }
  }
}
