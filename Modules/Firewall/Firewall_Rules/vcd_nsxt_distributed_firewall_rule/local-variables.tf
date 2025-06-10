locals {
  scope        = "TENANT"
  ip_protocol  = "IPV4"

  distributed_firewall_rules = {
    for k, v in var.distributed_firewall_rules : k => {
      name        = v.name
      action      = v.action
      ip_protocol = local.ip_protocol
      enabled     = v.enabled

      source_ids = try(
        [for src in v.source_ids : var.ip_sets_ids[src]],
        []
      )

      destination_ids = try(
        [for dst in v.destination_ids : var.ip_sets_ids[dst]],
        []
      )

      app_port_profile_ids = try(
        [for app in v.app_port_profile_ids : var.app_port_profiles_ids[app]],
        []
      )
    }
  }
}
