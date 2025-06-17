# Modulo Terraform `vcd_nsxt_firewall`

## Descrizione

Il modulo **`vcd_nsxt_firewall`** configura le **regole firewall dell’Edge Gateway NSX-T** in VMware Cloud Director. Queste regole regolano il traffico in entrata e in uscita verso l'Edge Gateway, agendo come firewall nord-sud.

Utilizza la risorsa `vcd_nsxt_firewall`.

---

## Requisiti

- Terraform >= 1.3
- Provider `vmware/vcd` >= 3.3.0
- VMware Cloud Director >= 10.2
- Edge Gateway NSX-T già configurato
- IP Set e Application Port Profile eventualmente già creati

---

## Input

| Variabile                   | Tipo          | Descrizione                                                       |
|----------------------------|---------------|-------------------------------------------------------------------|
| `vcd_auth_type`            | string        | Tipo di autenticazione (es. `BearerToken`)                        |
| `vcd_token`                | string        | Token API vCD (sensibile)                                         |
| `vcd_org`                  | string        | Nome dell’organizzazione                                          |
| `vcd_vdc`                  | string        | Nome del VDC                                                      |
| `vcd_api_version`          | string        | Versione dell’API                                                 |
| `vcd_allow_unverified_ssl` | bool          | Se `true`, accetta certificati SSL non verificati                 |
| `vcd_edge_gateway`         | string        | Nome dell'Edge Gateway NSX-T                                      |
| `vcd_vdc_group`            | string        | (Facoltativo) Nome del VDC Group                                  |
| `firewall_rules`           | map(object)   | Mappa delle regole da creare. Ogni oggetto include:               |
|                            |               | - `name` (string): nome della regola                              |
|                            |               | - `action` (string): `ALLOW` o `DROP`                             |
|                            |               | - `source_ids` (list(string), opzionale)                          |
|                            |               | - `destination_ids` (list(string), opzionale)                     |
|                            |               | - `app_port_profile_ids` (list(string), opzionale)                |
|                            |               | - `enabled` (bool): se la regola è attiva                         |
| `ip_sets_ids`              | map(string)   | Mappa nome → ID degli IP Set (opzionale)                          |
| `app_port_profiles_ids`    | map(string)   | Mappa nome → ID dei Port Profile (opzionale)                      |

---

## Output

_Nessun output definito._

---

## Esempio d'uso

```hcl
module "edge_fw" {
  source = "./Modules/Firewall/Firewall_Rules/vcd_nsxt_firewall"

  firewall_rules = {
    "AllowOutbound" = {
      name                 = "Allow Outbound",
      action               = "ALLOW",
      source_ids           = [],
      destination_ids      = [],
      app_port_profile_ids = [],
      enabled              = true
    },
    "BlockSSH" = {
      name                 = "Block SSH",
      action               = "DROP",
      source_ids           = [],
      destination_ids      = [],
      app_port_profile_ids = [module.app_port_profiles.app_port_profiles_ids["SSH"]],
      enabled              = true
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
  vcd_edge_gateway         = var.vcd_edge_gateway
}