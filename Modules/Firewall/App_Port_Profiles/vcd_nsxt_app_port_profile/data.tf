# EDGE GATEWAY

data "vcd_vdc_group" "this" {
  org  = var.vcd_org
  name = var.vcd_vdc_group
}

data "vcd_nsxt_edgegateway" "this" {
  name         = var.vcd_edge_gateway
  org          = var.vcd_org
  owner_id     = data.vcd_vdc_group.this.id
}

#-------------------------------------------------------------------------------------------------------------------------------

# APP PORT PROFILES

data "vcd_nsxt_app_port_profile" "this" {
  for_each = var.app_port_profiles

  name       = each.value.name
  org        = var.vcd_org
  scope      = local.scope
  context_id = data.vcd_vdc_group.this.id

  depends_on = [vcd_nsxt_app_port_profile.this]
}