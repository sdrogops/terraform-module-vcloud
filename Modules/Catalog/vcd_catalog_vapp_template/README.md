# Modulo Terraform `vcd_catalog_vapp_template`

## Descrizione

Il modulo **`vcd_catalog_vapp_template`** consente di caricare template OVA/OVF in un catalogo esistente di VMware Cloud Director. Utilizza la risorsa `vcd_catalog_item` del provider Terraform per vCD.

---

## Requisiti

- Terraform >= 1.3
- Provider `vmware/vcd` >= 2.0
- Un catalogo vCD già esistente (ottenibile da output di `vcd_catalog`)
- File OVA/OVF accessibile localmente o via URL
- Permessi per l’upload nel catalogo

---

## Input

| Variabile                    | Tipo            | Descrizione                                                                 |
|-----------------------------|-----------------|-----------------------------------------------------------------------------|
| `vcd_auth_type`             | string          | Tipo di autenticazione (es. `"BearerToken"`)                               |
| `vcd_token`                 | string          | Token API vCD (sensibile)                                                  |
| `vcd_org`                   | string          | Nome dell’organizzazione                                                   |
| `vcd_vdc`                   | string          | Nome del Virtual Data Center                                               |
| `vcd_api_version`           | string          | Versione dell’API da usare                                                 |
| `vcd_allow_unverified_ssl`  | bool            | Se `true`, consente SSL non verificato                                     |
| `vcd_edge_gateway`          | string          | Edge Gateway associato (opzionale)                                         |
| `vcd_vdc_group`             | string          | VDC Group (opzionale)                                                      |
| `catalog_vapp_template`     | map(object)     | Template da importare. Ogni oggetto ha:                                    |
|                             |                 | - `catalog_name`: nome del catalogo                                        |
|                             |                 | - `name`: nome del vApp template                                           |
|                             |                 | - `description`: descrizione del template                                  |
|                             |                 | - `ova_path`: percorso OVA/OVF (locale o URL accessibile dal provider)     |
| `catalogs_ids`              | map(string)     | Mappa nome catalogo → ID catalogo (da output del modulo `vcd_catalog`)     |

---

## Output

| Output                    | Tipo         | Descrizione                                                    |
|--------------------------|--------------|----------------------------------------------------------------|
| `vapp_templates_ids`     | map(string)  | Mappa nome template → ID assegnato nel catalogo vCD            |

---

## Esempio d'uso

```hcl
module "catalog_templates" {
  source = "./Modules/Catalog/vcd_catalog_vapp_template"

  vcd_auth_type            = var.vcd_auth_type
  vcd_token                = var.vcd_token
  vcd_org                  = var.vcd_org
  vcd_vdc                  = var.vcd_vdc
  vcd_api_version          = var.vcd_api_version
  vcd_allow_unverified_ssl = var.vcd_allow_unverified_ssl

  catalog_vapp_template = {
    "ubuntuTemplate" = {
      catalog_name = "Demo Catalog",
      name         = "Ubuntu-20.04-template",
      description  = "Template VM Ubuntu 20.04",
      ova_path     = "https://mio-server.local/templates/ubuntu.ova"
    }
  }

  catalogs_ids = module.vcd_catalog.catalogs_ids
}