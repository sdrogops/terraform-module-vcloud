locals {
  rule_type_no_snat = "NO_SNAT"
  firewall_match = "MATCH_INTERNAL_ADDRESS"
  logging = "true"
}

##-------------------------------------------------------------------------------------------------------------------------------#

# APP PORT PROFILES

locals {
  scope = "TENANT"
}