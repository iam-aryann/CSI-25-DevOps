## Task 4: Create a Service Connection in Azure DevOps

**Objective**:  
Create a Service Connection in Azure DevOps to securely connect your project with external services (e.g., Azure) for deployments and integrations.

---

## Prerequisites
- An Azure DevOps organization and project (e.g., from Week 7, Task 1).
- Project Administrator or Service Connection Administrator permissions.
- An Azure subscription with Contributor access.
- A working YAML or Classic pipeline to utilize the service connection.

---

## What is a Service Connection?
A Service Connection (or Service Endpoint) enables Azure DevOps pipelines to securely connect to external resources, such as:
- Azure (via Azure Resource Manager).
- Docker Registry (e.g., DockerHub, GHCR).
- GitHub.
- AWS.
- Generic services (via URL/token).

---

## Step-by-Step Guide

### Method 1: Using Azure DevOps UI
1. **Navigate to Service Connections**:
   - In your Azure DevOps project, go to **Project Settings** (bottom-left corner).
   - Select **Service connections** under the **Pipelines** section.
2. **Create a New Service Connection**:
   - Click **+ New service connection**.
   - Choose **Azure Resource Manager** from the list.
   - Select **Service principal (automatic)** for simplicity.
   - Click **Next**.
3. **Configure the Service Connection**:
   - **Subscription**: Select your Azure subscription (authorize if prompted).
   - **Resource Group**: Choose a specific resource group or leave as “All” for full access.
   - **Service connection name**: Enter `AzureRMServiceConnection`.
   - Check **Grant access permission to all pipelines** (recommended for ease of use).
4. **Save the Connection**:
   - Click **Save**.
   - The connection will appear in **Pipelines** > **Service connections**.

---

### After Creation
- The service connection (`AzureRMServiceConnection`) is ready for use in pipelines.
- It can be referenced in YAML or Classic pipelines for tasks like deploying to Azure Web Apps.

---

### YAML Example Using Service Connection
1. Create or edit a YAML pipeline (e.g., `azure-pipelines.yml`):
   ```yaml
   trigger:
     - main

   pool:
     vmImage: 'ubuntu-latest'

   variables:
     azureSubscription: 'AzureRMServiceConnection'  # Name of the service connection
     appName: 'my-webapp'

   stages:
     - stage: Deploy
       jobs:
         - job: DeployJob
           steps:
             - task: AzureWebApp@1
               inputs:
                 azureSubscription: $(azureSubscription)
                 appName: $(appName)
                 package: '$(System.DefaultWorkingDirectory)/**/*.zip'
   ```
   - This pipeline deploys a zipped application package to an Azure Web App using the `AzureRMServiceConnection`.

---

## References
- [YouTube: Azure DevOps Test Plans & Service Connections](https://www.youtube.com/results?search_query=azure+devops+service+connections)
- [YouTube: Azure DevOps Test Plans | Test Plans | Test Suites | Edureka
](https://www.youtube.com/watch?v=Cu7zx9u1sOE)
- [Microsoft Docs: Service Connections](https://learn.microsoft.com/azure/devops/pipelines/library/service-endpoints?view=azure-devops)
