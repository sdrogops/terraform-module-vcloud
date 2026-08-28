terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_nsxt_distributed_firewall_rule" "this" {
  for_each     = local.distributed_firewall_rules
  org          = var.vcd_org
  vdc_group_id = data.vcd_vdc_group.this.id

  name                 = each.value.name
  action               = each.value.action
  source_ids           = each.value.source_ids
  destination_ids      = each.value.destination_ids
  app_port_profile_ids = each.value.app_port_profile_ids
  enabled              = each.value.enabled

  # ip_protocol era calcolato nei locals ma non veniva mai passato alla
  # risorsa: le regole nascevano IPV4_IPV6 invece di IPV4.
  ip_protocol   = each.value.ip_protocol
  direction     = each.value.direction
  description   = each.value.description
  comment       = each.value.comment
  logging       = each.value.logging
  above_rule_id = var.above_rule_id

  depends_on = [
    data.vcd_nsxt_edgegateway.this,
    data.vcd_vdc_group.this
  ]
}