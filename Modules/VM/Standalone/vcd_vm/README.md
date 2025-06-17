# Modulo Terraform `vcd_vm`

## Descrizione

Il modulo **`vcd_vm`** crea una o più **macchine virtuali** in VMware Cloud Director a partire da template OVA/OVF presenti in un catalogo. Permette di personalizzare hardware, rete e sistema operativo per ogni VM creata.

Utilizza la risorsa `vcd_vm` con supporto per deployment da catalog item.

---

## Requisiti

- Terraform >= 1.3  
- Provider `vmware/vcd` >= 3.4.0  
- VMware Cloud Director >= 10.2  
- Template OVA/OVF già caricato in un catalogo (via `vcd_catalog_vapp_template`)  
- Permessi di deploy e provisioning VM

---

## Input

| Variabile                   | Tipo          | Descrizione                                                             |
|----------------------------|---------------|-------------------------------------------------------------------------|
| `vcd_auth_type`            | string        | Tipo di autenticazione (es. `BearerToken`)                              |
| `vcd_token`                | string        | Token API vCD (sensibile)                                               |
| `vcd_org`                  | string        | Nome dell’organizzazione                                                |
| `vcd_vdc`                  | string        | Nome del VDC                                                            |
| `vcd_api_version`          | string        | Versione dell’API                                                       |
| `vcd_allow_unverified_ssl` | bool          | Se `true`, accetta certificati SSL non verificati                       |
| `vcd_edge_gateway`         | string        | (Incluso per coerenza strutturale)                                      |
| `vcd_vdc_group`            | string        | (Opzionale) Nome del VDC Group                                          |
| `vm_list`                  | map(object)   | Mappa delle VM da creare. Ogni oggetto include:                         |
|                            |               | - `name`: nome della VM                                                 |
|                            |               | - `catalog_name`: nome del catalogo                                     |
|                            |               | - `template_name`: nome del vApp template                               |
|                            |               | - `cpu`: numero vCPU                                                    |
|                            |               | - `memory`: memoria in MB                                               |
|                            |               | - `hostname`: hostname da assegnare (guest customization)              |
|                            |               | - `network`: nome rete a cui connettere la VM                           |
|                            |               | - `ip_allocation_mode`: es. `POOL`, `DHCP`, `MANUAL`                    |
|                            |               | - `ip`: IP da assegnare (obbligatorio se `MANUAL`)                      |
|                            |               | - `enable_guest_customization`: bool                                   |
|                            |               | - `allow_in_guest_customization`: bool                                 |
|                            |               | - `password`: (opzionale) root/admin password                          |
|                            |               | - `override_template_disk_size`: (opzionale) dimensione disco GB        |
| `networks_ids`             | map(string)   | Mappa nome rete → ID rete (da `vcd_network_routed_v2`)                  |

---

## Output

| Output            | Tipo           | Descrizione