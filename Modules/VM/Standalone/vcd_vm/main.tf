terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_vm" "this" {
  for_each = var.vm

  name                           = each.value.name
  computer_name                  = each.value.computer_name
  vapp_template_id               = local.vapp_templates[each.value.vapp_template_name]
  cpus                           = each.value.cpus
  cpu_cores                      = each.value.cpus
  memory                         = each.value.memory * 1024
  cpu_hot_add_enabled            = local.cpu_hot_add_enabled
  memory_hot_add_enabled         = local.memory_hot_add_enabled
  expose_hardware_virtualization = local.expose_hardware_virtualization
  network_dhcp_wait_seconds      = local.network_dhcp_wait_seconds

  customization {
    enabled = local.customization_enabled
  }

  dynamic "network" {
    for_each = each.value.network
    content {
      name               = network.value
      type               = local.network_type
      ip_allocation_mode = local.ip_allocation_mode
    }
  }

  override_template_disk {
    bus_type     = local.disk_bus_type
    size_in_mb   = each.value.disk_size * 1024
    bus_number   = local.disk_bus_number_primary_disk
    unit_number  = local.disk_unit_number_primary_disk
    iops         = local.disk_iops_primary_disk
  }
}