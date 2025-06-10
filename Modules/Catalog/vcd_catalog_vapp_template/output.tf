output "vapp_templates_ids" {
  description = "Mappa nome_vapp_template => ID"
  value = {
    for k, v in data.vcd_catalog_vapp_template.this :
    local.catalog_vapp_templates[k].name => v.id
  }
}