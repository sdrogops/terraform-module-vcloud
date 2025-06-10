terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_network_routed_v2" "this" {
  for_each        = var.networks

  org             = var.vcd_org
  edge_gateway_id = data.vcd_nsxt_edgegateway.this.id

  name            = each.value.name
  description     = each.value.description
  gateway         = each.value.gateway
  prefix_length   = each.value.prefix_length
  dns1            = each.value.dns1
  dns2            = each.value.dns2

  depends_on = [
    data.vcd_nsxt_edgegateway.this
  ]
}
