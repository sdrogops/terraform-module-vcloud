terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_nsxt_distributed_firewall_rule" "this" {
  for_each        = local.distributed_firewall_rules
  org             = var.vcd_org
  vdc_group_id    = data.vcd_vdc_group.this.id

    name            = each.value.name
    action          = each.value.action
    source_ids      = each.value.source_ids
    destination_ids = each.value.destination_ids
    app_port_profile_ids = each.value.app_port_profile_ids
    enabled         = each.value.enabled 

depends_on = [
  data.vcd_nsxt_edgegateway.this,
  data.vcd_vdc_group.this
]
}