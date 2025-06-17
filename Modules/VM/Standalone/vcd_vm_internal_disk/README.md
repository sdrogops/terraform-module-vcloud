# Modulo Terraform `vcd_vm_internal_disk`

## Descrizione

Il modulo **`vcd_vm_internal_disk`** aggiunge **dischi interni aggiuntivi** (non boot) a VM esistenti in VMware Cloud Director. I dischi sono associati direttamente alla VM come dischi SCSI o IDE, espandendo lo storage disponibile.

Utilizza la risorsa `vcd_vm_internal_disk`.

---

## Requisiti

- Terraform >= 1.3  
- Provider `vmware/vcd` >= 3.4.0  
- VMware Cloud Director >= 10.2  
- VM esistente creata con `vcd_vm`  
- Permessi per modificare configurazioni VM

---

## Input

| Variabile                   | Tipo          | Descrizione                                                       |
|----------------------------|---------------|-------------------------------------------------------------------|
| `vcd_auth_type`            | string        | Tipo di autenticazione (es. `BearerToken`)                        |
| `vcd_token`                | string        | Token API vCD (sensibile)                                         |
| `vcd_org`                  | string        | Nome dell’organizzazione                                          |
| `vcd_vdc`                  | string        | Nome del VDC                                                      |
| `vcd_api_version`          | string        | Versione dell’API                                                 |
| `vcd_allow_unverified_ssl` | bool          | Se `true`, accetta certificati SSL non verificati                 |
| `disks`                    | map(object)   | Mappa dei dischi da creare. Ogni oggetto include:                 |
|                            |               | - `vm_name` (string): nome della VM a cui allegare il disco       |
|                            |               | - `bus_number` (number): numero bus (es. 0)                       |
|                            |               | - `unit_number` (number): posizione sul bus (es. 1, 2...)         |
|                            |               | - `size_in_mb` (number): dimensione del disco in MB               |
|                            |               | - `bus_type` (string): `SCSI` o `IDE`                             |
|                            |               | - `iops` (number, opzionale): limite IOPS                         |
|                            |               | - `storage_profile` (string, opzionale): profilo storage vCD      |

---

## Output

_Nessun output definito._

---

## Esempio d'uso

```hcl
module "internal_disk" {
  source = "./Modules/VM/Standalone/vcd_vm_internal_disk"

  disks = {
    "web1-disk01" = {
      vm_name         = "web1",
      bus_number      = 0,
      unit_number     = 1,
      size_in_mb      = 10240,
      bus_type        = "SCSI",
      iops            = 0,
      storage_profile = "Storage-Policy-Gold"
    }
  }

  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl
}