# Modulo Terraform `vcd_nsxt_network_dhcp_binding`

## Descrizione

Il modulo **`vcd_nsxt_network_dhcp_binding`** gestisce **DHCP static binding** per reti instradate NSX-T in VMware Cloud Director. Consente di riservare un indirizzo IP per una specifica interfaccia (MAC address), garantendo l’assegnazione fissa via DHCP a una VM.

Utilizza la risorsa `vcd_nsxt_network_dhcp_binding`.

---

## Requisiti

- Terraform >= 1.3  
- Provider `vmware/vcd` >= 3.9.0  
- VMware Cloud Director >= 10.3.1  
- Rete NSX-T con pool DHCP già configurato  
- Permessi per modificare la configurazione DHCP della rete

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
| `dhcp_bindings`            | map(object)   | Mappa dei binding da creare. Ogni oggetto include:                 |
|                            |               | - `org_network_name` (string): nome rete NSX-T target              |
|                            |               | - `mac_address` (string): MAC della VM                             |
|                            |               | - `ip_address` (string): IP da riservare                           |
|                            |               | - `hostname` (string, opzionale): nome host                        |
|                            |               | - `description` (string, opzionale): descrizione binding           |
| `network_ids`              | map(string)   | Mappa nome rete → ID (da modulo `vcd_network_routed_v2`)           |
| `vm_networks`              | map(string)   | (Facoltativo) Mappa VM → interfacce MAC (da output `vcd_vm`)       |

---

## Output

_Nessun output definito._

---

## Esempio d'uso

```hcl
module "dhcp_binding" {
  source = "./Modules/VM/Standalone/vcd_nsxt_network_dhcp_binding"

  dhcp_bindings = {
    "bind-web1" = {
      org_network_name = "Net-Frontend",
      mac_address      = "AA:BB:CC:DD:EE:FF",
      ip_address       = "10.10.10.50",
      hostname         = "web1",
      description      = "Static IP per web server 1"
    }
  }

  network_ids = module.networks.networks_ids
  vm_networks = module.vm.vm_networks

  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
}