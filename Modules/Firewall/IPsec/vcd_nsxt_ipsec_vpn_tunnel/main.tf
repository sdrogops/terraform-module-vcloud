terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_nsxt_ipsec_vpn_tunnel" "this" {
  for_each         = var.ipsec  
  org              = var.vcd_org
  edge_gateway_id  = data.vcd_nsxt_edgegateway.this.id  
  

  name              = each.value.name
  description       = each.value.description
  pre_shared_key    = each.value.pre_shared_key
  local_ip_address  = each.value.local_ip_address
  local_networks    = each.value.local_networks
  remote_ip_address = each.value.remote_ip_address
  remote_networks   = each.value.remote_networks

  security_profile_customization {
    ike_version                   = each.value.security_profile.ike_version
    ike_encryption_algorithms     = each.value.security_profile.ike_encryption_algorithms
    ike_digest_algorithms         = each.value.security_profile.ike_digest_algorithms
    ike_dh_groups                 = each.value.security_profile.ike_dh_groups
    ike_sa_lifetime               = each.value.security_profile.ike_sa_lifetime
    
    tunnel_pfs_enabled            = each.value.security_profile.tunnel_pfs_enabled
    tunnel_df_policy              = each.value.security_profile.tunnel_df_policy
    tunnel_encryption_algorithms  = each.value.security_profile.tunnel_encryption_algorithms
    tunnel_digest_algorithms      = each.value.security_profile.tunnel_digest_algorithms
    tunnel_dh_groups              = each.value.security_profile.tunnel_dh_groups
    tunnel_sa_lifetime            = each.value.security_profile.tunnel_sa_lifetime

    dpd_probe_internal            = each.value.security_profile.dpd_probe_internal
  }
}