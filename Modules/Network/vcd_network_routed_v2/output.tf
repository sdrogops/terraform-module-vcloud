output "networks_ids" {
  description = "Mappa nome_rete (dal vCD) => ID rete"
  value = {
    for _, v in vcd_network_routed_v2.this : v.name => v.id
  }
}