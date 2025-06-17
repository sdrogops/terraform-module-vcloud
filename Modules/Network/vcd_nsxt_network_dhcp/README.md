# Modulo Terraform `vcd_nsxt_network_dhcp`

## Descrizione

Il modulo **`vcd_nsxt_network_dhcp`** configura **pool DHCP** per reti instradate NSX-T in VMware Cloud Director. Poiché in NSX-T il DHCP non è configurato direttamente sulla rete, questa risorsa consente di definire pool separati associati alle reti esistenti.

Utilizza la risorsa `vcd_nsxt_network_dhcp`.

---

## Requisiti

- Terraform >= 1.3  
- Provider `vmware/vcd` >= 3.2.0  
- VMware Cloud Director >= 10.2  
- Reti instradate NSX-T già esistenti  
- Permessi per configurare il DHCP

---

## Input

| Variabile                   | Tipo          | Descrizione                                                        |
|----------------------------|---------------|--------------------------------------------------------------------|
| `vcd_auth_type`            | string        | Tipo di autenticazione (es. `BearerToken`)                         |
| `vcd_token`                | string        | Token API vCD (sensibile)                                          |
| `vcd_org`                  | string        | Nome dell’organizzazione                                           |
| `vcd_vdc`                  | string        | Nome del VDC                                                       |
| `vcd_api_version`          | string        | Versione dell’API                                                  |
| `vcd_allow_unverified_ssl` | bool          | Se `true`, accetta certificati SSL non verificati                  |
| `vcd_edge_gateway`         | string        | Edge Gateway NSX-T (necessario per il provider)                    |
| `vcd_vdc_group`            | string        | (Facoltativo) Nome del VDC Group                                   |
| `dhcp_pools`               | map(object)   | Mappa dei pool DHCP. Ogni oggetto include:                         |
|                            |               | - `org_network_name` (string): nome della rete target              |
|                            |               | - `start_address` (string): inizio range IP                        |
|                            |               | - `end_address` (string): fine range IP                            |
|                            |               | - `lease_time` (number, opzionale): lease in secondi               |
|                            |               | - `preferred_dns` (string, opzionale)                              |
|                            |               | - `alternate_dns` (string, opzionale)                              |
|                            |               | - `dns_suffix` (string, opzionale)                                 |
| `networks_ids`             | map(string)   | Mappa nome rete → ID rete (da `vcd_network_routed_v2`)             |

---

## Output

_Nessun output definito._

---

## Esempio d'uso

```hcl
module "dhcp_config" {
  source = "./Modules/Network/vcd_nsxt_network_dhcp"

  dhcp_pools = {
    "frontend" = {
      org_network_name = "Net-Frontend",
      start_address    = "10.10.10.100",
      end_address      = "10.10.10.150",
      lease_time       = 86400
    },
    "backend" = {
      org_network_name = "Net-Backend",
      start_address    = "10.10.20.50",
      end_address      = "10.10.20.60"
    }
  }

  networks_ids = module.networks.networks_ids

  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
  vcd_edge_gateway         = var.vcd_edge_gateway
}