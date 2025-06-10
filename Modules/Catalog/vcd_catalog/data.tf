data "vcd_catalog" "this" {
  for_each = var.catalog
  name     = each.value.name
  org      = var.vcd_org
  depends_on = [vcd_catalog.this]
}