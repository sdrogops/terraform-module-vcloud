# Modulo Terraform `vcd_nsxt_app_port_profile`

## Descrizione

Il modulo **`vcd_nsxt_app_port_profile`** crea uno o più **Application Port Profile** su un Edge Gateway NSX-T in VMware Cloud Director. Questi profili combinano protocollo e porta (o range di porte) e possono essere usati in regole firewall o NAT per definire il traffico applicativo.

---

## Requisiti

- Terraform >= 1.3
- Provider `vmware/vcd` >= 3.3.0
- VMware Cloud Director >= 10.2 con Edge Gateway basato su NSX-T
- Permessi a livello di organizzazione per la creazione dei profili

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
| `vcd_edge_gateway`         | string        | Nome dell'Edge Gateway NSX-T su cui creare i profili             |
| `vcd_vdc_group`            | string        | (Opzionale) Nome del VDC Group                                   |
| `app_port_profiles`        | map(object)   | Mappa dei profili da creare. Ogni oggetto include:               |
|                            |               | - `name` (string): nome del profilo                              |
|                            |               | - `description` (string): descrizione                            |
|                            |               | - `protocol` (string): `TCP` o `UDP`                             |
|                            |               | - `port` (string): porta o range (es. `"80"`, `"1000-2000"`)     |

---

## Output

| Output                      | Tipo          | Descrizione                                                      |
|----------------------------|---------------|------------------------------------------------------------------|
| `app_port_profiles_ids`    | map(string)   | Mappa nome profilo → ID generato in vCD                          |

---

## Esempio d'uso

```hcl
module "app_port_profiles" {
  source = "./Modules/Firewall/App_Port_Profiles/vcd_nsxt_app_port_profile"

  app_port_profiles = {
    "http" = {
      name        = "HTTP",
      description = "Traffico HTTP",
      protocol    = "TCP",
      port        = "80"
    },
    "custom" = {
      name        = "CustomApp",
      description = "App su porta 9000-9010",
      protocol    = "UDP",
      port        = "9000-9010"
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