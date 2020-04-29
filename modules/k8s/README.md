# K8s in Azure

## Deploy with Terraform

module: `modules/kubernetes`

Deploying a k8s cluster using this module (or any other Terraform code for that matter) at the moment won't have autoscaling capabilities for the nodes.

Because k8s with vmss is still in preview status and not supported by terraform yet, which can only be enabled via azure cli.

If k8s autoscaler is not needed, using this approach is totally automatic and infrastructure as code; only manual step being creating a service principal for k8s.

## Deploy using Azure CLI with k8s autoscaler

If autoscaling for k8s nodes is needed, deploying with Azure CLI as follows:

```
az extension add --name aks-preview
az feature register --name VMSSPreview --namespace Microsoft.ContainerService
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/VMSSPreview')].{Name:name,State:properties.state}"
# wait till the status in the previous command's stdout is "registered"
az provider register --namespace Microsoft.ContainerService

export service_principal={SERVICE_PRICIPAL_ID_HERE_GET_FROM_1PASSWORD}
export client_secret={SERVICE_PRICIPAL_PWD_HERE_GET_FROM_1PASSWORD}
az aks create \
  --resource-group k8s-dev \
  --name k8s-dev \
  --kubernetes-version 1.12.6 \
  --node-count 1 \
  --enable-vmss \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 3 \
  --admin-username ansible \
  --ssh-key-value /Users/t.guo/ssh-key-ansible-internal-sub/id_rsa.pub \
  --vnet-subnet-id /subscriptions/0f8d6e64-28c8-422d-8cbd-bc5da452c55d/resourceGroups/internal-network-dev/providers/Microsoft.Network/virtualNetworks/internal-vnet-dev/subnets/internal-backendsubnet-dev \
  --service-principal $service_principal \
  --client-secret $client_secret \
  --node-osdisk-size 30 \
  --node-vm-size Standard_DS2_v2
```

For more details see [HERE](https://docs.microsoft.com/en-us/azure/aks/cluster-autoscaler).

At the moment, no matter how you deploy k8s (via portal, terraffform, cli), a service principal is always needed, can be existing one or create a new one.

