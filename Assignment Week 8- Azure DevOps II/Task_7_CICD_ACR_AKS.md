## Task 7: Create a CI/CD Pipeline to Build and Push a Docker Image to Azure Container Registry (ACR) and Deploy to Azure Kubernetes Service (AKS)

**Objective**:  
Create an Azure DevOps CI/CD pipeline to build a Docker image, push it to Azure Container Registry (ACR), and deploy it to an Azure Kubernetes Service (AKS) cluster.

---

## Prerequisites
- An Azure subscription with:
  - Azure Container Registry (ACR) created.
  - Azure Kubernetes Service (AKS) cluster created.
- An Azure DevOps project (e.g., from Week 7, Task 1).
- Service connection for Azure Resource Manager (ARM) to access ACR and AKS (e.g., from Week 8, Task 4).
- A Git repository containing:
  - A `Dockerfile` for the application.
  - Kubernetes manifest file (e.g., `manifests/deployment.yaml`).
- Permissions to manage pipelines and service connections.

---

## Step-by-Step Pipeline Setup

### Step 1: Create a Service Connection to Azure
1. In Azure DevOps, go to **Project Settings** > **Service connections**.
2. Click **+ New service connection** and select **Azure Resource Manager**.
3. Choose **Service principal (automatic)**.
4. Configure:
   - **Subscription**: Select your Azure subscription (authorize if prompted).
   - **Resource Group**: Select the resource group containing ACR and AKS, or leave as “All”.
   - **Service connection name**: `AzureRMServiceConnection` (or a custom name).
   - Check **Grant access permission to all pipelines**.
5. Click **Save**.

---

### Step 2: YAML Pipeline to Build & Push to ACR
1. Create a file named `.azure-pipelines/docker-build-push.yaml` in your repository:
   ```yaml
   trigger:
     - main

   variables:
     imageName: myapp

   stages:
     - stage: Build
       displayName: Build and Push Docker Image
       jobs:
         - job: Docker
           pool:
             vmImage: 'ubuntu-latest'
           steps:
             - task: AzureCLI@2
               inputs:
                 azureSubscription: 'AzureRMServiceConnection'
                 scriptType: bash
                 scriptLocation: inlineScript
                 inlineScript: |
                   az acr login --name <yourACRName>
                   docker build -t <yourACRName>.azurecr.io/$(imageName):$(Build.BuildId) .
                   docker push <yourACRName>.azurecr.io/$(imageName):$(Build.BuildId)
   ```
   - Replace `<yourACRName>` with your ACR name (e.g., `myacr`).
   - The pipeline builds a Docker image and pushes it to ACR with a tag based on the build ID.

---

### Step 3: Deploy to AKS Using Kubernetes Manifest
1. Add a deployment stage to the same YAML pipeline:
   ```yaml
     - stage: Deploy
       displayName: Deploy to AKS
       dependsOn: Build
       jobs:
         - job: DeployToAKS
           pool:
             vmImage: 'ubuntu-latest'
           steps:
             - task: Kubernetes@1
               displayName: Deploy to AKS
               inputs:
                 connectionType: 'Azure Resource Manager'
                 azureSubscriptionEndpoint: 'AzureRMServiceConnection'
                 azureResourceGroup: '<your-resource-group>'
                 kubernetesCluster: '<your-aks-cluster>'
                 namespace: 'default'
                 command: apply
                 useConfigurationFile: true
                 configuration: 'manifests/deployment.yaml'
   ```
   - Replace `<your-resource-group>` with your AKS resource group.
   - Replace `<your-aks-cluster>` with your AKS cluster name.

---

### Sample `deployment.yaml`
1. Create a Kubernetes manifest file at `manifests/deployment.yaml` in your repository:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: myapp-deployment
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: myapp
     template:
       metadata:
         labels:
           app: myapp
       spec:
         containers:
         - name: myapp
           image: <yourACRName>.azurecr.io/myapp:$(Build.BuildId)
           ports:
           - containerPort: 80
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: myapp-service
   spec:
     type: LoadBalancer
     selector:
       app: myapp
     ports:
       - protocol: TCP
         port: 80
         targetPort: 80
   ```
   - Replace `<yourACRName>` with your ACR name.
   - The manifest deploys the application with 2 replicas and exposes it via a LoadBalancer service.

---

### Test the CI/CD Flow
1. Commit and push changes to the `main` branch:
   ```bash
   git add .
   git commit -m "Add CI/CD pipeline for ACR and AKS"
   git push origin main
   ```
2. Monitor the pipeline in **Pipelines** > **Builds**:
   - The **Build** stage builds and pushes the Docker image to ACR.
   - The **Deploy** stage applies the Kubernetes manifest to AKS.
3. Verify deployment:
   - Run `kubectl get svc -n default` to get the external IP of `myapp-service`.
   - Access the app via the external IP in a browser (e.g., `http://<external-ip>`).

---

## Resources
- [Microsoft Docs: Azure DevOps Pipelines](https://learn.microsoft.com/azure/devops/pipelines/?view=azure-devops)
- [Azure DevOps Artifacts | Azure Artifacts In Azure DevOps | Using Azure DevOps Artifacts | Edureka
](https://www.youtube.com/watch?v=o9OpFMQMSHw)
- [YouTube: Azure DevOps with AKS](https://www.youtube.com/results?search_query=azure+devops+aks)
