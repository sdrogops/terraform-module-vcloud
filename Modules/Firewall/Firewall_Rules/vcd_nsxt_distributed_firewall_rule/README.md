# Modulo Terraform `vcd_nsxt_distributed_firewall_rule`

## Descrizione

Il modulo **`vcd_nsxt_distributed_firewall_rule`** crea **regole di firewall distribuito (Distributed Firewall)** su un VDC Group NSX-T in VMware Cloud Director. Le regole vengono applicate direttamente alle interfacce delle VM per una microsegmentazione efficace.

Utilizza la risorsa `vcd_nsxt_distributed_firewall_rule` per gestire ogni regola singolarmente.

---

## Requisiti

- Terraform >= 1.3
- Provider `vmware/vcd` >= 3.10.0
- VMware Cloud Director >= 10.4.1
- VDC Group con NSX-T
- IP Set e Application Port Profile già creati (opzionale)

---

## Input

| Variabile                      | Tipo          | Descrizione                                                       |
|-------------------------------|---------------|-------------------------------------------------------------------|
| `vcd_auth_type`               | string        | Tipo di autenticazione (es. `BearerToken`)                        |
| `vcd_token`                   | string        | Token API vCD (sensibile)                                         |
| `vcd_org`                     | string        | Nome dell’organizzazione                                          |
| `vcd_vdc`                     | string        | VDC principale                                                    |
| `vcd_api_version`             | string        | Versione dell’API                                                 |
| `vcd_allow_unverified_ssl`    | bool          | Se `true`, accetta certificati SSL non verificati                 |
| `vcd_edge_gateway`            | string        | Edge Gateway (non usato direttamente, ma incluso per consistenza) |
| `vcd_vdc_group`               | string        | Nome del VDC Group su cui applicare le regole                     |
| `distributed_firewall_rules`  | map(object)   | Mappa delle regole da creare. Ogni oggetto include:               |
|                               |               | - `name` (string): nome della regola                              |
|                               |               | - `action` (string): `ALLOW` o `DROP`                             |
|                               |               | - `source_ids` (list(string), opzionale)                          |
|                               |               | - `destination_ids` (list(string), opzionale)                     |
|                               |               | - `app_port_profile_ids` (list(string), opzionale)                |
|                               |               | - `enabled` (bool): se la regola è attiva                         |
| `ip_sets_ids`                 | map(string)   | (Facoltativo) ID IP Set da referenziare                           |
| `app_port_profiles_ids`       | map(string)   | (Facoltativo) ID Port Profile da referenziare                     |

---

## Output

_Nessun output definito._

---

## Esempio d'uso

```hcl
module "distributed_fw" {
  source = "./Modules/Firewall/Firewall_Rules/vcd_nsxt_distributed_firewall_rule"

  distributed_firewall_rules = {
    "AllowWeb" = {
      name                 = "Allow Web",
      action               = "ALLOW",
      source_ids           = [],
      destination_ids      = [module.ip_sets.ip_sets_ids["web-servers"]],
      app_port_profile_ids = [module.app_port_profiles.app_port_profiles_ids["http"]],
      enabled              = true
    },
    "DenyAll" = {
      name      = "Deny All",
      action    = "DROP",
      enabled   = true
    }
  }

  ip_sets_ids           = module.ip_sets.ip_sets_ids
  app_port_profiles_ids = module.app_port_profiles.app_port_profiles_ids

  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_vdc_group            = var.vcd_vdc_group
}