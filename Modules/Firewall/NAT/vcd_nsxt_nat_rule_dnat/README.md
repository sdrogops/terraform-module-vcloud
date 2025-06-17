# Modulo Terraform `vcd_nsxt_nat_rule_dnat`

## Descrizione

Il modulo **`vcd_nsxt_nat_rule_dnat`** crea regole **DNAT (Destination NAT)** sull’Edge Gateway NSX-T in VMware Cloud Director. Le regole DNAT permettono di pubblicare servizi interni su indirizzi IP e porte esterni, consentendo l’accesso dall’esterno verso l’interno.

Utilizza la risorsa `vcd_nsxt_nat_rule` con tipo `DNAT`.

---

## Requisiti

- Terraform >= 1.3  
- Provider `vmware/vcd` >= 3.3.0  
- VMware Cloud Director >= 10.2 con NSX-T  
- Un Edge Gateway NSX-T configurato  
- Permessi per gestire le regole NAT

---

## Input

| Variabile              | Tipo        | Descrizione                                                               |
|------------------------|-------------|---------------------------------------------------------------------------|
| `vcd_auth_type`        | string      | Tipo di autenticazione (es. `BearerToken`)                                |
| `vcd_token`            | string      | Token API vCD (sensibile)                                                 |
| `vcd_org`              | string      | Nome dell’organizzazione                                                  |
| `vcd_vdc`              | string      | Nome del Virtual Data Center                                              |
| `vcd_api_version`      | string      | Versione dell’API                                                         |
| `vcd_allow_unverified_ssl` | bool    | Se `true`, accetta certificati SSL non verificati                         |
| `vcd_edge_gateway`     | string      | Edge Gateway NSX-T su cui creare la regola                                |
| `dnat`                 | map(object) | Mappa di regole DNAT da creare. Ogni oggetto include:                     |
|                        |             | - `name` (string): nome della regola                                      |
|                        |             | - `description` (string, opzionale): descrizione                          |
|                        |             | - `external_address` (string): IP pubblico dell’Edge                      |
|                        |             | - `external_port` (string): porta o range da esporre                      |
|                        |             | - `internal_address` (string): IP interno della VM o servizio             |
|                        |             | - `internal_port` (string): porta interna del servizio                    |
|                        |             | - `protocol` (string): `TCP`, `UDP` o `any`                               |
|                        |             | - `enabled` (bool): attivazione della regola                              |

---

## Output

_Nessun output definito._

---

## Esempio d'uso

```hcl
module "nat_dnat" {
  source = "./Modules/Firewall/NAT/vcd_nsxt_nat_rule_dnat"

  dnat = {
    "web443" = {
      name             = "DNAT Web",
      description      = "Espone il web server interno su porta 443",
      external_address = "203.0.113.10",
      external_port    = "443",
      internal_address = "10.10.10.10",
      internal_port    = "443",
      protocol         = "TCP",
      enabled          = true
    }
  }

  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
}