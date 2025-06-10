terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_nsxt_nat_rule" "dnat" {
  for_each         = var.dnat
  org              = var.vcd_org
  edge_gateway_id  = data.vcd_nsxt_edgegateway.this.id

  rule_type        = local.rule_type_dnat
  name             = each.value.name
  description      = each.value.description
  
  external_address    = each.value.external_address
  internal_address    = each.value.internal_address
  dnat_external_port  = each.value.dnat_external_port
  app_port_profile_id = try(var.app_port_profiles_ids[each.value.app_port_profile_id], null)
  priority            = each.value.priority
  firewall_match      = local.firewall_match
  logging             = local.logging
}