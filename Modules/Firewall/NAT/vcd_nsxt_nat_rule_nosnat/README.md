# Modulo Terraform `vcd_nsxt_nat_rule_nosnat`

## Descrizione

Il modulo **`vcd_nsxt_nat_rule_nosnat`** crea regole **No SNAT (Reflexive NAT)** su un Edge Gateway NSX-T in VMware Cloud Director. Le regole No SNAT permettono di escludere specifici flussi di traffico dall'applicazione di regole SNAT, mantenendo l'indirizzo IP sorgente originale.

Utilizza la risorsa `vcd_nsxt_nat_rule` con tipo `NO_SNAT`.

---

## Requisiti

- Terraform >= 1.3  
- Provider `vmware/vcd` >= 3.3.0  
- VMware Cloud Director >= 10.3 (supporto Reflexive NAT)  
- Edge Gateway NSX-T configurato  
- Regole SNAT già in uso (le No SNAT servono a eccezione selettiva)

---

## Input

| Variabile                   | Tipo          | Descrizione                                                        |
|----------------------------|---------------|--------------------------------------------------------------------|
| `vcd_auth_type`            | string        | Tipo di autenticazione (es. `BearerToken`)                         |
| `vcd_token`                | string        | Token API vCD (sensibile)                                          |
| `vcd_org`                  | string        | Nome dell’organizzazione                                           |
| `vcd_vdc`                  | string        | Nome del Virtual Data Center                                       |
| `vcd_api_version`          | string        | Versione dell’API                                                  |
| `vcd_allow_unverified_ssl` | bool          | Se `true`, accetta certificati SSL non verificati                  |
| `vcd_edge_gateway`         | string        | Nome dell'Edge Gateway NSX-T                                       |
| `no_snat`                  | map(object)   | Mappa di regole No SNAT. Ogni oggetto include:                     |
|                            |               | - `name` (string): nome della regola                               |
|                            |               | - `description` (string, opzionale): descrizione                   |
|                            |               | - `internal_address` (string): IP o subnet sorgente                |
|                            |               | - `snat_destination_address` (string, opzionale): destinazione     |
|                            |               | - `priority` (number, opzionale): priorità della regola            |
|                            |               | - `enabled` (bool): se attiva o meno                               |

---

## Output

_Nessun output definito._

---

## Esempio d'uso

```hcl
module "nat_no_snat" {
  source = "./Modules/Firewall/NAT/vcd_nsxt_nat_rule_nosnat"

  no_snat = {
    "nosnat-to-partner" = {
      name                    = "NoSNAT-to-Partner",
      description             = "Non fare SNAT verso 203.0.113.0/24",
      internal_address        = "10.10.0.0/16",
      snat_destination_address = "203.0.113.0/24",
      enabled                 = true
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