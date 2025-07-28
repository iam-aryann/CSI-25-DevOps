## Task 8: Create a CI/CD Pipeline to Build & Push a Docker Image to ACR and Deploy to Azure Container Instances (ACI)

**Objective**:  
Automate the process of building a Docker image, pushing it to Azure Container Registry (ACR), and deploying it to Azure Container Instances (ACI) using an Azure DevOps CI/CD pipeline.

---

## Prerequisites
- An Azure subscription with:
  - Azure Container Registry (ACR) created.
  - Azure Container Instances (ACI) access enabled.
- An Azure DevOps project with a Git repository (e.g., from Week 7, Task 1).
- An Azure Resource Manager (ARM) service connection (e.g., from Week 8, Task 4).
- A repository containing:
  - A `Dockerfile` for the application.
  - A simple app (e.g., `app/main.py`, `app/index.html`, or `app/App.java`).
- Permissions to manage pipelines, service connections, and variable groups.

---

## Folder Structure Example
```
.
├── Dockerfile
├── app/
│   └── main.py  # Or index.html, App.java, etc.
├── manifests/
│   └── aci.yaml  # Optional, if using manifest-based deployment
├── azure-pipelines/
│   └── build-push-deploy.yml
```

---

## Step-by-Step Pipeline Setup

### 1. Create a Service Connection in Azure DevOps
1. Go to **Project Settings** > **Service connections**.
2. Click **+ New service connection** and select **Azure Resource Manager**.
3. Choose **Service principal (automatic)**.
4. Configure:
   - **Subscription**: Select your Azure subscription (authorize if prompted).
   - **Resource Group**: Select the resource group for ACR and ACI, or leave as “All”.
   - **Service connection name**: `AzureRMServiceConnection`.
   - Check **Grant access permission to all pipelines**.
5. Click **Save**.

---

### 2. Set Up Secrets in Variable Group
1. Go to **Pipelines** > **Library** and click **+ Variable group**.
2. Create a variable group:
   - **Name**: `ACRCredentials`
   - **Variables**:
     - `ACR_USERNAME`: Run `az acr credential show --name <yourACRName>` in Azure CLI and copy the `username`.
     - `ACR_PASSWORD`: Copy the `password` from the same command (mark as secret by clicking the lock icon).
   - Enable **Allow access to all pipelines**.
3. Save the variable group.

---

### 3. YAML Pipeline to Build, Push, and Deploy
1. Create a file named `.azure-pipelines/build-push-deploy.yml` in your repository:
   ```yaml
   trigger:
     - main

   variables:
     imageName: myapp
     acrName: <yourACRName>
     containerGroup: myapp-container
     resourceGroup: <your-resource-group>
     location: eastus
     - group: ACRCredentials  # Link variable group

   stages:
     - stage: BuildAndPush
       jobs:
         - job: Build
           pool:
             vmImage: 'ubuntu-latest'
           steps:
             - task: AzureCLI@2
               inputs:
                 azureSubscription: 'AzureRMServiceConnection'
                 scriptType: bash
                 scriptLocation: inlineScript
                 inlineScript: |
                   az acr login --name $(acrName)
                   docker build -t $(acrName).azurecr.io/$(imageName):$(Build.BuildId) .
                   docker push $(acrName).azurecr.io/$(imageName):$(Build.BuildId)

     - stage: DeployToACI
       dependsOn: BuildAndPush
       jobs:
         - job: Deploy
           pool:
             vmImage: 'ubuntu-latest'
           steps:
             - task: AzureCLI@2
               inputs:
                 azureSubscription: 'AzureRMServiceConnection'
                 scriptType: bash
                 scriptLocation: inlineScript
                 inlineScript: |
                   az container create \
                     --name $(containerGroup) \
                     --resource-group $(resourceGroup) \
                     --image $(acrName).azurecr.io/$(imageName):$(Build.BuildId) \
                     --cpu 1 \
                     --memory 1 \
                     --registry-login-server $(acrName).azurecr.io \
                     --registry-username $(ACR_USERNAME) \
                     --registry-password $(ACR_PASSWORD) \
                     --dns-name-label $(imageName)-$(Build.BuildId) \
                     --ports 80
   ```
   - Replace `<yourACRName>` with your ACR name (e.g., `myacr`).
   - Replace `<your-resource-group>` with your Azure resource group name.
   - Ensure the `ACRCredentials` variable group is linked for `ACR_USERNAME` and `ACR_PASSWORD`.

---

### 4. Test the CI/CD Flow
1. Commit and push changes to the `main` branch:
   ```bash
   git add .
   git commit -m "Add CI/CD pipeline for ACR and ACI"
   git push origin main
   ```
2. Monitor the pipeline in **Pipelines** > **Builds**:
   - **BuildAndPush** stage: Builds the Docker image and pushes it to ACR.
   - **DeployToACI** stage: Deploys the image to ACI.
3. Verify deployment:
   - Run `az container show --name myapp-container --resource-group <your-resource-group>` to get the container’s public URL.
   - Access the app at `http://myapp-<BuildID>.eastus.azurecontainer.io`.

---

## Resources
- [Microsoft Docs: Deploy to Azure Container Instances](https://learn.microsoft.com/azure/container-instances/container-instances-quickstart)
- [Azure DevOps Artifacts | Azure Artifacts In Azure DevOps | Using Azure DevOps Artifacts | Edureka
](https://www.youtube.com/watch?v=o9OpFMQMSHw)
- [Microsoft Docs: Azure DevOps Pipelines YAML](https://learn.microsoft.com/azure/devops/pipelines/yaml-schema?view=azure-devops)
- [YouTube: Azure DevOps with ACI](https://www.youtube.com/results?search_query=azure+devops+container+instances)
