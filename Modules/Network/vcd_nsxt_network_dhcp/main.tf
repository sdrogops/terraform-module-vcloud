terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_nsxt_network_dhcp" "this" {
  for_each = var.dhcp_pools

  org_network_id = var.networks_ids[each.value.org_network_name]
  dns_servers    = try(each.value.dns_servers, [])

  pool {
    start_address = each.value.start_address
    end_address   = each.value.end_address
  }
}