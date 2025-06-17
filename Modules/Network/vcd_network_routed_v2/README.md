# Modulo Terraform `vcd_network_routed_v2`

## Descrizione

Il modulo **`vcd_network_routed_v2`** crea **reti instradate (Org VDC Routed Networks)** in VMware Cloud Director, supportando backend NSX-T e NSX-V. Le reti sono connesse a un Edge Gateway e possono essere utilizzate per collegare VM interne al traffico esterno secondo policy definite.

Utilizza la risorsa `vcd_network_routed_v2`.

---

## Requisiti

- Terraform >= 1.3  
- Provider `vmware/vcd` >= 3.2.0  
- VMware Cloud Director >= 10.2  
- Edge Gateway NSX-T o NSX-V configurato  
- Permessi per creare reti nell’organizzazione

---

## Input

| Variabile                   | Tipo          | Descrizione                                                          |
|----------------------------|---------------|----------------------------------------------------------------------|
| `vcd_auth_type`            | string        | Tipo di autenticazione (es. `BearerToken`)                           |
| `vcd_token`                | string        | Token API vCD (sensibile)                                            |
| `vcd_org`                  | string        | Nome dell’organizzazione                                             |
| `vcd_vdc`                  | string        | Nome del Virtual Data Center                                         |
| `vcd_api_version`          | string        | Versione dell’API                                                    |
| `vcd_allow_unverified_ssl` | bool          | Se `true`, accetta certificati SSL non verificati                    |
| `vcd_edge_gateway`         | string        | Nome dell'Edge Gateway                                               |
| `vcd_vdc_group`            | string        | (Facoltativo) Nome del VDC Group (per NSX-T cross-VDC)              |
| `networks`                 | map(object)   | Reti da creare. Ogni oggetto include:                                |
|                            |               | - `name` (string): nome rete                                         |
|                            |               | - `description` (string, opzionale)                                  |
|                            |               | - `gateway` (string): IP gateway in CIDR (es. `10.10.10.1/24`)       |
|                            |               | - `dns_servers` (list(string), opzionale)                            |
|                            |               | - `dns_suffix` (string, opzionale)                                   |
|                            |               | - `ip_range` (string, opzionale): intervallo IP (es. `10.10.10.2-100`)|
|                            |               | - `shared` (bool, opzionale): rete condivisa (solo NSX-T)            |
|                            |               | - `distributed_interface` (bool, opzionale): segment distribuito     |

---

## Output

| Output           | Tipo          | Descrizione                                      |
|------------------|---------------|--------------------------------------------------|
| `networks_ids`   | map(string)   | Mappa nome rete → ID rete creata in vCD         |

---

## Esempio d'uso

```hcl
module "networks" {
  source = "./Modules/Network/vcd_network_routed_v2"

  networks = {
    "frontend" = {
      name        = "Net-Frontend",
      description = "Rete per i web server",
      gateway     = "10.10.10.1/24",
      dns_servers = ["8.8.8.8"],
      dns_suffix  = "lab.local"
    },
    "backend" = {
      name        = "Net-Backend",
      description = "Rete per database",
      gateway     = "10.10.20.1/24"
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