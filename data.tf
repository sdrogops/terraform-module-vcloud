data "vcd_catalog" "catalogs" {
  for_each = {
    for k, v in var.catalog_vapp_template : v.catalog_name => {
      catalog_name = v.catalog_name
    }
  }

  name = each.value.catalog_name
  org  = var.vcd_org

  depends_on = [ module.vcd_catalog ]
}