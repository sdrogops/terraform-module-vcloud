output "ip_sets_ids" {
  description = "Mappa nome_ip_set => ID IP Set"
  value = {
    for k, v in data.vcd_nsxt_ip_set.this :
    v.name => v.id
  }
}