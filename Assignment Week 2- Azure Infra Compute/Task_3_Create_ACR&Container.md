# Task 3: Create Azure Container Registry (ACR), Push Docker Image, and Create a Container from It


## 1. Create Azure Container Registry using Azure Portal
Steps followed on Azure Portal:

1. Go to Azure Portal → Search for **Container Registries**.
2. Click on **Create**.
3. Enter the following:
   - **Subscription**: (Your active subscription)
   - **Resource Group**: azure4everyone-appservice-intro
   - **Registry Name**: a4econtainerregistry
   - **Location**: (Same region as your container instance)
   - **SKU**: Basic
4. Click **Review + Create**, then **Create**.

## 2. Login to ACR and Tag the Local Image
Assuming a simple Docker image (e.g., `helloacrnodedemo`) is created locally:

```bash
az acr login --name a4econtainerregistry
docker tag helloacrnodedemo a4econtainerregistry.azurecr.io/helloacrnodedemo:v1
```

## 3. Push Docker Image to ACR
```bash
docker push a4econtainerregistry.azurecr.io/helloacrnodedemo:v1
```

## 4. Create a Container Instance from the Image in ACR
```bash
az container create \
  --resource-group azure4everyone-appservice-intro \
  --name acr-container-demo \
  --image a4econtainerregistry.azurecr.io/helloacrnodedemo:v1 \
  --registry-login-server a4econtainerregistry.azurecr.io \
  --dns-name-label acrcontainer-a4e \
  --ports 80 \
  --cpu 1 \
  --memory 1.5
```

## 5. Verify Deployment
```bash
az container show \
  --name acr-container-demo \
  --resource-group azure4everyone-appservice-intro \
  --query ipAddress.fqdn \
  --output table
```

Open the FQDN in your browser to verify the application is running.

## Resource
- [Azure Container Registry and Container File Systems
](https://www.youtube.com/watch?v=7lfhxgI7wpQ)
