locals {
  catalog_vapp_templates = {
    for k, v in var.catalog_vapp_template : k => merge(v, {
      catalog_id = var.catalogs_ids[v.catalog_name]
    })
  }
}
