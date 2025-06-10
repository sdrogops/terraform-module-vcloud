output "vm_networks" {
  description = "Dettagli rete delle VM (MAC, IP, Network, ID VM)"
  value = {
    for _, vm in vcd_vm.this : vm.name => {
      vm_id   = vm.id
      vm_name = vm.name
      vapp_name = vm.vapp_name
      networks = {
        for net in vm.network : net.name => {
          network_name       = net.name
          ip_address         = net.ip
          ip_allocation_mode = net.ip_allocation_mode
          mac_address        = net.mac
        }
      }
    }
  }
}
