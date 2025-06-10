output "catalogs_ids" {
  description = "Mappa nome_catalogo => catalog_id"
  value = {
    for k, v in data.vcd_catalog.this :
    var.catalog[k].name => v.id
  }
}
