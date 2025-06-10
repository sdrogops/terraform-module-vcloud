terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_nsxt_ip_set" "this" {
  for_each         = var.ip_sets
  org              = var.vcd_org
  edge_gateway_id  = data.vcd_nsxt_edgegateway.this.id  
  
  name             = each.value.name
  description      = each.value.description
  ip_addresses     = each.value.ip_addresses
}