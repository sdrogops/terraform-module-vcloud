#locals {
#  catalog_vapp_templates = {
#    for k, v in var.catalog_vapp_template : k => merge(v, {
#      catalog_id = data.vcd_catalog.by_name[v.catalog_name].id
#    })
#  }
#}
