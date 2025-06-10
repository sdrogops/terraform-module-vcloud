terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_nsxt_app_port_profile" "this" {
  for_each         = var.app_port_profiles
  org              = var.vcd_org
  context_id       = data.vcd_vdc_group.this.id

  name             = each.value.name
  description      = each.value.description
  scope            = local.scope
  
  app_port {
    protocol = each.value.protocol
    port     = each.value.port
  }
}
