# VMware Cloud Director Terraform Modules

This repository contains a collection of Terraform modules used to manage VMware Cloud Director resources such as catalogs, networks and virtual machines.

## Prerequisites

- Terraform 1.3 or newer
- Access to a VMware Cloud Director instance and an API token

## Required Provider Variables

The root module expects the following variables in order to configure the VMware `vcd` provider:

- `vcd_auth_type` – authentication type, typically `BearerToken`
- `vcd_token` – API token used to authenticate
- `vcd_org` – organization name
- `vcd_vdc` – name of the virtual data center
- `vcd_url` – base URL of the vCloud Director API
- `vcd_api_version` – API version to use
- `vcd_allow_unverified_ssl` – set to `true` to allow self-signed certificates
- `vcd_edge_gateway` – edge gateway name
- `vcd_vdc_group` – datacenter group name

## Example `terraform.tfvars`

```hcl
vcd_auth_type            = "BearerToken"
vcd_token                = "your-api-token"
vcd_org                  = "my-org"
vcd_vdc                  = "my-vdc"
vcd_url                  = "https://vcd.example.com/api"
vcd_api_version          = "36.0"
vcd_allow_unverified_ssl = true
vcd_edge_gateway         = "my-edge"
vcd_vdc_group            = "my-group"
```

Populate additional module variables (e.g. catalogs, networks, VMs) as required.

## Usage

Initialize the working directory and download providers:

```shell
terraform init
```

Review the execution plan:

```shell
terraform plan
```

Apply the configuration:

```shell
terraform apply
```

