data "vcd_catalog_vapp_template" "this" {
  for_each = local.catalog_vapp_templates

  name        = each.value.name
  catalog_id  = each.value.catalog_id
  org         = var.vcd_org

  depends_on = [vcd_catalog_vapp_template.this]
}