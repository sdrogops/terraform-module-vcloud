# Modulo Terraform `vcd_nsxt_nat_rule_snat`

## Descrizione

Il modulo **`vcd_nsxt_nat_rule_snat`** crea regole **SNAT (Source NAT)** su un Edge Gateway NSX-T in VMware Cloud Director. Le regole SNAT riscrivono l’indirizzo IP sorgente di pacchetti in uscita da una rete privata con un indirizzo pubblico o dell’Edge, consentendo la comunicazione verso l’esterno.

Utilizza la risorsa `vcd_nsxt_nat_rule` con tipo `SNAT`.

---

## Requisiti

- Terraform >= 1.3  
- Provider `vmware/vcd` >= 3.3.0  
- VMware Cloud Director >= 10.2  
- Un Edge Gateway NSX-T già configurato  
- Permessi per gestire regole NAT

---

## Input

| Variabile               | Tipo         | Descrizione                                                         |
|-------------------------|--------------|---------------------------------------------------------------------|
| `vcd_auth_type`         | string       | Tipo di autenticazione (es. `BearerToken`)                          |
| `vcd_token`             | string       | Token API vCD (sensibile)                                           |
| `vcd_org`               | string       | Nome dell’organizzazione                                            |
| `vcd_vdc`               | string       | Nome del Virtual Data Center                                        |
| `vcd_api_version`       | string       | Versione dell’API                                                   |
| `vcd_allow_unverified_ssl` | bool      | Se `true`, accetta certificati SSL non verificati                   |
| `vcd_edge_gateway`      | string       | Nome dell'Edge Gateway NSX-T su cui applicare la regola             |
| `snat`                  | map(object)  | Mappa di regole SNAT da creare. Ogni oggetto include:               |
|                         |              | - `name` (string): nome della regola                                |
|                         |              | - `description` (string, opzionale): descrizione                    |
|                         |              | - `internal_address` (string): IP o subnet privata da riscrivere    |
|                         |              | - `external_address` (string): IP pubblico da usare come sorgente   |
|                         |              | - `snat_policy` (string, opzionale): es. `REFLEXIVE` (se supportato)|
|                         |              | - `enabled` (bool): attivazione regola                              |

---

## Output

_Nessun output definito._

---

## Esempio d'uso

```hcl
module "nat_snat" {
  source = "./Modules/Firewall/NAT/vcd_nsxt_nat_rule_snat"

  snat = {
    "snat-out" = {
      name             = "SNAT Internal",
      description      = "Permette l’uscita a Internet da rete interna",
      internal_address = "10.10.0.0/16",
      external_address = "203.0.113.5",
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