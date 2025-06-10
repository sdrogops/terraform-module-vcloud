terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_nsxt_network_dhcp_binding" "this" {
  for_each = local.dhcp_bindings

  org            = var.vcd_org
  name           = each.value.name
  description    = each.value.description
  org_network_id = each.value.org_network_id
  ip_address     = each.value.ip_address
  mac_address    = each.value.mac_address
  dns_servers    = each.value.dns_servers
  binding_type   = local.binding_type
  lease_time     = local.lease_time
}