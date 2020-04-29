# Azure Terraform Modules and Examples

## Pre-requisites
* Install [terraform](https://www.terraform.io/) 0.12 required
* Install [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)

## How to Run

### Remote State Files

See the other repo:

https://github.com/IronCore864/tf-remote-state-azure-storage-account

### config.tf

Create a config.tf file for the env you choose to deploy, according to the template `config.tf.template`.

You need subscription, service principal related info, as well as the storage account info generated in the previous step.

### k8s Service Principal

For k8s service principal, open the file:

```
dev/terraform.tfvars
```

And put the value for `service_principal_id_for_k8s` and `service_principal_secret_for_k8s`.

This should not be commited to this repo since it's credentials. For now we don't have a vault.

### Deploy

* `terraform init` - Initializes the environment
* `terrafrom plan` - Displays execution plan
* `terraform apply` - Applies execution plan
