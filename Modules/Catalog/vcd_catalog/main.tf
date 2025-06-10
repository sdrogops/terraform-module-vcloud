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

  delete_recursive              = local.delete_recursive
  delete_force                  = local.delete_force
  publish_enabled               = local.publish_enabled
  preserve_identity_information = local.preserve_identity_information
  cache_enabled                 = local.cache_enabled
}