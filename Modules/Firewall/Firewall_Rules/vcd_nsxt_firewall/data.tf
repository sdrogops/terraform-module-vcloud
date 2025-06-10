# VDC GROUP

data "vcd_vdc_group" "this" {
  org  = var.vcd_org
  name = var.vcd_vdc_group
}

# EDGE GATEWAY

data "vcd_nsxt_edgegateway" "this" {
  name         = var.vcd_edge_gateway
  org          = var.vcd_org
  owner_id     = data.vcd_vdc_group.this.id
}