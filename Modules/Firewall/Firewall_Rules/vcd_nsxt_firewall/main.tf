terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_nsxt_firewall" "this" {
  org             = var.vcd_org
  edge_gateway_id = data.vcd_nsxt_edgegateway.this.id

  dynamic "rule" {
    for_each = local.firewall_rules
    content {
      name                 = rule.value.name
      action               = rule.value.action
      direction            = rule.value.direction
      ip_protocol          = rule.value.ip_protocol
      source_ids           = rule.value.source_ids
      destination_ids      = rule.value.destination_ids
      app_port_profile_ids = rule.value.app_port_profile_ids
      enabled              = rule.value.enabled
    }
  }

depends_on = [
  data.vcd_nsxt_edgegateway.this,
  data.vcd_vdc_group.this
]
}