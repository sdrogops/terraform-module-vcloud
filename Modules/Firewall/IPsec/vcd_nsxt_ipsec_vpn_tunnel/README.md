# Modulo Terraform `vcd_nsxt_ipsec_vpn_tunnel`

## Descrizione

Il modulo **`vcd_nsxt_ipsec_vpn_tunnel`** crea tunnel **IPSec VPN site-to-site** tra un Edge Gateway NSX-T in VMware Cloud Director e un endpoint remoto. Questo consente la comunicazione sicura tra il VDC e un altro sito (on-premise o cloud).

Utilizza la risorsa `vcd_nsxt_ipsec_vpn_tunnel`.

---

## Requisiti

- Terraform >= 1.3  
- Provider `vmware/vcd` >= 3.3.0  
- VMware Cloud Director >= 10.1  
- Edge Gateway NSX-T configurato con indirizzo IP pubblico  
- Permessi per gestire VPN e networking

---

## Input

| Variabile                | Tipo          | Descrizione                                                             |
|--------------------------|---------------|-------------------------------------------------------------------------|
| `vcd_auth_type`          | string        | Tipo di autenticazione (es. `BearerToken`)                              |
| `vcd_token`              | string        | Token API vCD (sensibile)                                               |
| `vcd_org`                | string        | Nome dell’organizzazione                                                |
| `vcd_vdc`                | string        | Nome del VDC                                                            |
| `vcd_api_version`        | string        | Versione dell’API                                                       |
| `vcd_allow_unverified_ssl` | bool        | Se `true`, accetta certificati SSL non verificati                       |
| `vcd_edge_gateway`       | string        | Nome dell'Edge Gateway NSX-T                                            |
| `ipsec`                  | map(object)   | Mappa di configurazioni IPSec VPN. Ogni oggetto include:                |
|                          |               | - `name` (string): nome del tunnel                                      |
|                          |               | - `description` (string, opzionale)                                     |
|                          |               | - `pre_shared_key` (string): chiave segreta condivisa                   |
|                          |               | - `local_ip_address` (string): IP pubblico dell’Edge                    |
|                          |               | - `local_networks` (list(string)): reti locali                          |
|                          |               | - `remote_ip_address` (string): IP del peer remoto                      |
|                          |               | - `remote_networks` (list(string)): reti remote                         |
|                          |               | - `security_profile` (object): parametri IPSec (vedi sotto)             |

### Struttura `security_profile`

| Campo                         | Tipo              | Descrizione                                 |
|------------------------------|-------------------|---------------------------------------------|
| `ike_version`                | string            | Versione IKE (`IKE_V1`, `IKE_V2`)           |
| `ike_encryption_algorithms`  | list(string)      | Algoritmi IKE (es. `["AES_256"]`)           |
| `ike_digest_algorithms`      | list(string)      | Algoritmi hash IKE (es. `["SHA256"]`)       |
| `ike_dh_groups`              | list(string)      | Gruppi DH IKE (es. `["GROUP14"]`)           |
| `ike_sa_lifetime`            | number            | Lifetime fase 1 (secondi)                   |
| `tunnel_encryption_algorithms` | list(string)    | Algoritmi di cifratura fase 2               |
| `tunnel_digest_algorithms`  | list(string)       | Algoritmi hash fase 2                       |
| `tunnel_dh_groups`          | list(string)       | Gruppi DH fase 2                            |
| `tunnel_sa_lifetime`        | number             | Lifetime fase 2 (secondi)                   |
| `tunnel_pfs_enabled`        | bool               | Perfect Forward Secrecy                     |
| `tunnel_df_policy`          | string             | Politica DF (`COPY`, `CLEAR`, ecc.)         |
| `dpd_probe_internal`        | number             | Intervallo DPD (secondi)                    |

---

## Output

_Nessun output definito._

---

## Esempio d'uso

```hcl
module "ipsec" {
  source = "./Modules/Firewall/IPsec/vcd_nsxt_ipsec_vpn_tunnel"

  ipsec = {
    "siteA-to-siteB" = {
      name               = "SiteA-SiteB-VPN",
      description        = "Tunnel VPN verso sito B",
      pre_shared_key     = "SuperSecret123!",
      local_ip_address   = "198.51.100.10",
      local_networks     = ["10.0.0.0/16"],
      remote_ip_address  = "203.0.113.5",
      remote_networks    = ["10.50.0.0/16"],

      security_profile = {
        ike_version                = "IKE_V2",
        ike_encryption_algorithms = ["AES_256"],
        ike_digest_algorithms     = ["SHA256"],
        ike_dh_groups             = ["GROUP14"],
        ike_sa_lifetime           = 28800,
        tunnel_encryption_algorithms = ["AES_256"],
        tunnel_digest_algorithms = ["SHA256"],
        tunnel_dh_groups          = ["GROUP14"],
        tunnel_sa_lifetime        = 3600,
        tunnel_pfs_enabled        = true,
        tunnel_df_policy          = "COPY",
        dpd_probe_internal        = 10
      }
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