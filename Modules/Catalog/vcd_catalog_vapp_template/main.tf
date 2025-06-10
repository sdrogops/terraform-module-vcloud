terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_catalog_vapp_template" "this" {
  for_each = local.catalog_vapp_templates

  org                = var.vcd_org
  name               = each.value.name
  description        = each.value.description
  ova_path           = each.value.ova_path
  catalog_id         = each.value.catalog_id
  upload_piece_size  = each.value.upload_piece_size
}
