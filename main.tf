terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

provider "vcd" {
  auth_type            = var.vcd_auth_type
  token                = var.vcd_token
  org                  = var.vcd_org
  vdc                  = var.vcd_vdc
  url                  = var.vcd_url
  allow_unverified_ssl = var.vcd_allow_unverified_ssl
}

module "vcd_catalog" {
  source = "./modules/vcd_catalog"

  # Provider config
  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_url                  = var.vcd_url
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
  vcd_vdc_group            = var.vcd_vdc_group

  # Catalog config
  catalog                                   = var.catalog
  vcd_catalog_delete_recursive              = var.vcd_catalog_delete_recursive
  vcd_catalog_delete_force                  = var.vcd_catalog_delete_force
  vcd_catalog_publish_enabled               = var.vcd_catalog_publish_enabled
  vcd_catalog_preserve_identity_information = var.vcd_catalog_preserve_identity_information
  vcd_catalog_cache_enabled                 = var.vcd_catalog_cache_enabled
}

module "vcd_catalog_vapp_template" {
  source = "./modules/vcd_catalog_vapp_template"

  # Provider config
  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
#  vcd_url                  = var.vcd_url
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
  vcd_vdc_group            = var.vcd_vdc_group

  catalog_vapp_template  = local.catalog_vapp_templates

  depends_on = [ module.vcd_catalog ]
}
