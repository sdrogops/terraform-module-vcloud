terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_nsxt_nat_rule" "no_snat" {
  for_each         = var.no_snat
  org              = var.vcd_org
  edge_gateway_id  = data.vcd_nsxt_edgegateway.this.id

  rule_type        = local.rule_type_no_snat
  name             = each.value.name
  description      = each.value.description
  
  internal_address = each.value.internal_address
  snat_destination_address = each.value.snat_destination_address
  priority =  each.value.priority
  firewall_match   = local.firewall_match
  logging          = local.logging
}