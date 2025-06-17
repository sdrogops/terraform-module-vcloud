# Modulo Terraform `vcd_catalog`

## Descrizione

Il modulo **`vcd_catalog`** crea uno o più cataloghi in una organizzazione di VMware Cloud Director (vCD). Un catalogo è un contenitore di vApp template, immagini ISO e altri media utilizzabili per distribuire macchine virtuali.

Questo modulo utilizza la risorsa `vcd_catalog` del provider Terraform per vCD.

---

## Requisiti

- Terraform >= 1.3
- Provider `vmware/vcd` >= 2.0
- Accesso a un'istanza vCD con permessi di creazione cataloghi
- Variabili di autenticazione e configurazione del provider vCD

---

## Input

| Variabile                  | Tipo     | Descrizione                                                                          |
|---------------------------|----------|--------------------------------------------------------------------------------------|
| `vcd_auth_type`           | string   | Tipo di autenticazione (es. `"BearerToken"`)                                        |
| `vcd_token`               | string   | Token API vCD (sensibile)                                                            |
| `vcd_vdc`                 | string   | Nome del Virtual Data Center                                                        |
| `vcd_url`                 | string   | Endpoint dell’API di vCloud Director                                                |
| `vcd_api_version`         | string   | Versione dell’API da usare                                                          |
| `vcd_allow_unverified_ssl`| bool     | Se `true`, consente SSL non verificato                                              |
| `vcd_org`                 | string   | Nome dell’organizzazione                                                            |
| `vcd_edge_gateway`        | string   | Edge Gateway associato (opzionale, per coerenza strutturale)                        |
| `vcd_vdc_group`           | string   | VDC Group (opzionale)                                                                |
| `catalog`                 | map(object) | Mappa di cataloghi da creare, con i seguenti campi:<br>• `name`<br>• `description` |

---

## Output

| Output         | Tipo              | Descrizione                                           |
|----------------|-------------------|-------------------------------------------------------|
| `catalogs_ids` | map(string)       | Mappa nome catalogo → ID catalogo generato in vCD    |

---

## Esempio d'uso

```hcl
provider "vcd" {
  auth_type            = "BearerToken"
  token                = var.vcd_token
  org                  = var.vcd_org
  vdc                  = var.vcd_vdc
  url                  = var.vcd_url
  allow_unverified_ssl = true
}

module "catalog" {
  source = "./Modules/Catalog/vcd_catalog"

  catalog = {
    "demo" = {
      name        = "Demo Catalog"
      description = "Catalogo per template di esempio"
    }
  }
}