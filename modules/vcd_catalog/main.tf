terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_catalog" "this" {
  for_each                      = var.catalog
  name                          = each.value.name
  description                   = each.value.description

  delete_recursive              = var.vcd_catalog_delete_recursive
  delete_force                  = var.vcd_catalog_delete_force
  publish_enabled               = var.vcd_catalog_publish_enabled
  preserve_identity_information = var.vcd_catalog_preserve_identity_information
  cache_enabled                 = var.vcd_catalog_cache_enabled
}