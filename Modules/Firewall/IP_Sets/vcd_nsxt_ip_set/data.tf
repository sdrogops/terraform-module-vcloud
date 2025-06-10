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

#-------------------------------------------------------------------------------------------------------------------------------#

# IP SETS

data "vcd_nsxt_ip_set" "this" {
  for_each = var.ip_sets

  name            = each.value.name
  org             = var.vcd_org
  edge_gateway_id = data.vcd_nsxt_edgegateway.this.id

  depends_on = [vcd_nsxt_ip_set.this]
}
