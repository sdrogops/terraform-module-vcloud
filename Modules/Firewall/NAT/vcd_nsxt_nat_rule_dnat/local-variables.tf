locals {
  rule_type_dnat  = "DNAT"
  firewall_match  = "MATCH_INTERNAL_ADDRESS"
  logging         = "true"
}

##-------------------------------------------------------------------------------------------------------------------------------#

# APP PORT PROFILES

locals {
  scope           = "TENANT"
}
