locals {
  catalog_vapp_templates = {
    for k, v in var.catalog_vapp_template : k => {
      name              = v.name
      description       = v.description
      ova_path          = v.ova_path
      upload_piece_size = v.upload_piece_size
      catalog_id        = data.vcd_catalog.catalogs[v.catalog_name].id
    }
  }
  depends_on = [ module.vcd_catalog ]
}
