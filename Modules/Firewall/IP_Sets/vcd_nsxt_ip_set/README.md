# Modulo Terraform `vcd_nsxt_ip_set`

## Descrizione

Il modulo **`vcd_nsxt_ip_set`** crea uno o più **IP Set** su NSX-T in VMware Cloud Director. Gli IP Set sono gruppi di indirizzi IP o subnet utilizzabili come origine o destinazione nelle regole firewall e NAT.

---

## Requisiti

- Terraform >= 1.3
- Provider `vmware/vcd` >= 3.3.0
- VMware Cloud Director >= 10.2 con supporto NSX-T
- Permessi per creare e gestire IP Set nell’organizzazione

---

## Input

| Variabile                   | Tipo          | Descrizione                                                      |
|----------------------------|---------------|------------------------------------------------------------------|
| `vcd_auth_type`            | string        | Tipo di autenticazione (es. `BearerToken`)                       |
| `vcd_token`                | string        | Token API vCD (sensibile)                                        |
| `vcd_org`                  | string        | Nome dell’organizzazione                                         |
| `vcd_vdc`                  | string        | Nome del Virtual Data Center                                     |
| `vcd_api_version`          | string        | Versione dell’API vCD                                            |
| `vcd_allow_unverified_ssl` | bool          | Se `true`, accetta certificati SSL non verificati                |
| `vcd_edge_gateway`         | string        | Nome dell'Edge Gateway (richiesto dal provider, anche se non usato direttamente) |
| `vcd_vdc_group`            | string        | (Opzionale) Nome del VDC Group                                   |
| `ip_sets`                  | map(object)   | Mappa degli IP Set da creare. Ogni oggetto include:              |
|                            |               | - `name` (string): nome dell’IP Set                              |
|                            |               | - `description` (string): descrizione                            |
|                            |               | - `ip_addresses` (list(string)): IP o subnet da includere        |

---

## Output

| Output           | Tipo          | Descrizione                                       |
|------------------|---------------|---------------------------------------------------|
| `ip_sets_ids`    | map(string)   | Mappa nome IP Set → ID assegnato in vCD          |

---

## Esempio d'uso

```hcl
module "ip_sets" {
  source = "./Modules/Firewall/IP_Sets/vcd_nsxt_ip_set"

  ip_sets = {
    "web-servers" = {
      name         = "WebServers",
      description  = "IP dei frontend web",
      ip_addresses = ["10.10.10.0/24", "10.10.20.10"]
    },
    "db" = {
      name         = "Database",
      description  = "IP database server",
      ip_addresses = ["10.10.30.5"]
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