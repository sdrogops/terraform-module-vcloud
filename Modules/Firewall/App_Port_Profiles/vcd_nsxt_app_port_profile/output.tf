output "app_port_profiles_ids" {
  description = "Mappa name => ID degli app port profile"
  value = {
    for k, v in data.vcd_nsxt_app_port_profile.this :
    v.name => v.id
  }
}