terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

resource "vcd_vm_internal_disk" "this" {
  for_each = var.disks

  org               = var.vcd_org
  vdc               = var.vcd_vdc
  vm_name           = each.value.vm_name
  vapp_name         = var.vm_networks[each.value.vm_name].vapp_name
  size_in_mb        = each.value.size_in_gb * 1024
  bus_number        = each.value.bus_number
  unit_number       = each.value.unit_number
  bus_type          = local.bus_type
  storage_profile   = each.value.storage_profile
  allow_vm_reboot   = local.allow_vm_reboot
}