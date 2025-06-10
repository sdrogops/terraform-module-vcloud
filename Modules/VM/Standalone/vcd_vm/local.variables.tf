locals {
  cpu_hot_add_enabled = true
  memory_hot_add_enabled = true
  expose_hardware_virtualization   = true
  network_dhcp_wait_seconds = 30
  customization_enabled = true
  consolidate_disks_on_create = true
  network_type = "org"
  ip_allocation_mode = "DHCP"
  disk_bus_type = "paravirtual"
  disk_bus_number_primary_disk = 0
  disk_unit_number_primary_disk = 0
  disk_iops_primary_disk = 0
  disk_bus_start = 1
}

#-------------------------------------------------------------------------------------------------------------------------------

locals {
  vapp_templates = var.vapp_templates_ids
  networks       = var.networks_ids
}