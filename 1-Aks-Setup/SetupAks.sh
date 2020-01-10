# Install azure CLI
https://docs.microsoft.com/en-gb/cli/azure/install-azure-cli?view=azure-cli-latest

brew install azure-cli

# Install kubectl CLI
https://kubernetes.io/docs/tasks/tools/install-kubectl/

brew install kubectl 

# Install VsCode Extension
https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools

# Login to Azure
az login

# Use correct account if you got more than one on your account
az account set -s "SE Team GBG CSP"

# Create resource group for the cluster, specifing name and location
# Note that all vm sizes are not availible in all location, choose wisely, tricky to change.
az group create -n k8lab -l northeurope

# Create the cluster
# It takes ~20 minutes to set it up
# -c Set node count to 3
# -s Set VM Size to Standard_B2s
az aks create -n labcluster -g k8lab -c 3  -s Standard_B2s

# ONLY FOR DEV PURPOSE, Quick way to get routing and ip for your cluster, Takes about ~5 min or so..
az aks enable-addons --resource-group k8lab --name labcluster --addons http_application_routing


# After creation we´ll want the public DNS
az aks show --resource-group k8lab  --name labcluster --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName -o table

# Connect your kubectl cli to Azure AKS without a lot of config
az aks get-credentials --n labcluster --resource-group k8lab

# If you have more than one cluster in your configfile
# Check your contexts
kubectl config view 

# Set our cluster as default
kubectl config use-context labcluster

# Add role for the dashboard
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard

# browse the dashboard
az aks browse --resource-group k8lab --name labcluster


