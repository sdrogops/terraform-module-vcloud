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

# ---------------------------------------------------------------------------------------------------

# CATALOG

module "vcd_catalog" {
  source = "./Modules/Catalog/vcd_catalog"

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
}

# ---------------------------------------------------------------------------------------------------

# CATALOG VAPP TEMPLATE

module "vcd_catalog_vapp_template" {
  source = "./Modules/Catalog/vcd_catalog_vapp_template"

  # Provider config
  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
  vcd_vdc_group            = var.vcd_vdc_group

  # Catalog vApp template config

  catalog_vapp_template = var.catalog_vapp_template
  catalogs_ids          = module.vcd_catalog.catalogs_ids

  depends_on = [module.vcd_catalog]
  }


# ---------------------------------------------------------------------------------------------------

# APP PORT PROFILES

module "vcd_nsxt_app_port_profile" {
  source = "./Modules/Firewall/App_Port_Profiles/vcd_nsxt_app_port_profile"

  # Provider config
  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
  vcd_vdc_group            = var.vcd_vdc_group

  app_port_profiles = var.app_port_profiles
}

# ---------------------------------------------------------------------------------------------------

# IP SETS

module "vcd_nsxt_ip_set" {
  source = "./Modules/Firewall/IP_Sets/vcd_nsxt_ip_set"

  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
  vcd_vdc_group            = var.vcd_vdc_group

  ip_sets = var.ip_sets
}

# ---------------------------------------------------------------------------------------------------

# DISTRIBUTED FIREWALL RULES

module "vcd_nsxt_distributed_firewall_rule" {
  source = "./Modules/Firewall/Firewall_Rules/vcd_nsxt_distributed_firewall_rule"

  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
  vcd_vdc_group            = var.vcd_vdc_group

  ip_sets_ids             = module.vcd_nsxt_ip_set.ip_sets_ids
  app_port_profiles_ids   = module.vcd_nsxt_app_port_profile.app_port_profiles_ids
  distributed_firewall_rules = var.distributed_firewall_rules
}

# ---------------------------------------------------------------------------------------------------

# FIREWALL RULES

module "vcd_nsxt_firewall" {
  source = "./Modules/Firewall/Firewall_Rules/vcd_nsxt_firewall"

  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
  vcd_vdc_group            = var.vcd_vdc_group

  ip_sets_ids             = module.vcd_nsxt_ip_set.ip_sets_ids
  app_port_profiles_ids   = module.vcd_nsxt_app_port_profile.app_port_profiles_ids
  firewall_rules          = var.firewall_rules
}

# ---------------------------------------------------------------------------------------------------

# DNAT

module "vcd_nsxt_nat_rule_dnat" {
  source = "./Modules/Firewall/NAT/vcd_nsxt_nat_rule_dnat"

  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
  vcd_vdc_group            = var.vcd_vdc_group

  app_port_profiles_ids = module.vcd_nsxt_app_port_profile.app_port_profiles_ids
  dnat                  = var.dnat
}

# ---------------------------------------------------------------------------------------------------

# NO SNAT

module "vcd_nsxt_nat_rule_no_snat" {
  source = "./Modules/Firewall/NAT/vcd_nsxt_nat_rule_nosnat"

  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
  vcd_vdc_group            = var.vcd_vdc_group

  no_snat = var.no_snat
}

# ---------------------------------------------------------------------------------------------------

# SNAT

module "vcd_nat_rule_snat" {
  source = "./Modules/Firewall/NAT/vcd_nsxt_nat_rule_snat"

  # Provider config
  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
  vcd_vdc_group            = var.vcd_vdc_group

  # Config specifici
  snat               = var.snat
}

# ---------------------------------------------------------------------------------------------------

# # IPsec

# module "vcd_ipsec_vpn_tunnel" {
#   source = "./Modules/Firewall/IPsec/vcd_nsxt_ipsec_vpn_tunnel"

#   vcd_auth_type            = var.vcd_auth_type
#   vcd_token                = var.vcd_token
#   vcd_org                  = var.vcd_org
#   vcd_vdc                  = var.vcd_vdc
#   vcd_api_version          = var.vcd_api_version
#   vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
#   vcd_edge_gateway         = var.vcd_edge_gateway
#   vcd_vdc_group            = var.vcd_vdc_group

#   ipsec = var.ipsec
# }

# ---------------------------------------------------------------------------------------------------

# NETWORKS

module "vcd_network_routed_v2" {
  source = "./Modules/Network/vcd_network_routed_v2"

  # Provider
  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
  vcd_vdc_group            = var.vcd_vdc_group

  # Network
  networks = var.networks
}

# ---------------------------------------------------------------------------------------------------

# NETWORK DHCP POOLS

module "vcd_nsxt_network_dhcp" {
  source = "./Modules/Network/vcd_nsxt_network_dhcp"

  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
  vcd_vdc_group            = var.vcd_vdc_group

  dhcp_pools   = var.dhcp_pools
  networks_ids = module.vcd_network_routed_v2.networks_ids

  depends_on = [ module.vcd_network_routed_v2 ]
}

# ---------------------------------------------------------------------------------------------------

# VM

module "vcd_vm" {
  source = "./Modules/VM/Standalone/vcd_vm"

  # Provider
  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
  vcd_vdc_group            = var.vcd_vdc_group

  # Input dati
  vm                      = var.vm
  catalogs_ids            = module.vcd_catalog.catalogs_ids
  vapp_templates_ids      = module.vcd_catalog_vapp_template.vapp_templates_ids
  networks_ids            = module.vcd_network_routed_v2.networks_ids

  depends_on = [
    module.vcd_catalog,
    module.vcd_catalog_vapp_template
  ]
}


module "vcd_dhcp_binding" {
  source = "./Modules/VM/Standalone/vcd_nsxt_network_dhcp_binding"

  # Provider
  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
  vcd_vdc_group            = var.vcd_vdc_group

  dhcp_bindings   = var.dhcp_bindings
  network_ids     = module.vcd_network_routed_v2.networks_ids
  vm_networks     = module.vcd_vm.vm_networks

  depends_on = [ module.vcd_vm, module.vcd_network_routed_v2 ]
}


module "vcd_vm_internal_disk" {
  source = "./Modules/VM/Standalone/vcd_vm_internal_disk"

  vcd_org                   = var.vcd_org
  vcd_vdc                   = var.vcd_vdc
  vcd_auth_type             = var.vcd_auth_type
  vcd_token                 = var.vcd_token
  vcd_api_version           = var.vcd_api_version
  vcd_allow_unverified_ssl  = var.vcd_allow_unverified_ssl

  disks        = var.disks
  vm_networks  = module.vcd_vm.vm_networks

  depends_on = [ module.vcd_vm ]
}
