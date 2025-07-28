## Task 9: Create a CI/CD Pipeline to Build a .NET Application and Deploy It to Azure App Service

**Objective**:  
Automate the process of building a .NET application and deploying it to an Azure App Service using an Azure DevOps CI/CD pipeline.

---

## Prerequisites
- An Azure subscription with an Azure App Service (Windows or Linux) created.
- An Azure DevOps project with a Git repository containing a .NET application (preferably ASP.NET Core).
- An Azure Resource Manager (ARM) service connection (e.g., from Week 8, Task 4).
- Permissions to manage pipelines and service connections.

---

## Sample Project Structure
```
.
├── MyApp/
│   ├── MyApp.csproj
│   ├── Controllers/
│   ├── Views/
│   └── Program.cs
├── .azure-pipelines/
│   └── dotnet-deploy.yml
```

---

## Step-by-Step Pipeline Setup

### 1. Create Azure Service Connection
1. In Azure DevOps, go to **Project Settings** > **Service connections**.
2. Click **+ New service connection** and select **Azure Resource Manager**.
3. Choose **Service principal (automatic)**.
4. Configure:
   - **Subscription**: Select your Azure subscription (authorize if prompted).
   - **Resource Group**: Select the resource group for your App Service, or leave as “All”.
   - **Service connection name**: `AzureRMServiceConnection`.
   - Check **Grant access permission to all pipelines**.
5. Click **Save**.

---

### 2. Set Up Variables in a Variable Group
1. Go to **Pipelines** > **Library** and click **+ Variable group**.
2. Create a variable group:
   - **Name**: `AppServiceConfig`
   - **Variables**:
     - `azureSubscription`: `AzureRMServiceConnection` (name of your service connection).
     - `appName`: `<your-app-service-name>` (e.g., `my-webapp`).
   - Enable **Allow access to all pipelines**.
3. Save the variable group.

---

### 3. Create CI/CD Pipeline YAML
1. Create a file named `.azure-pipelines/dotnet-deploy.yml` in your repository:
   ```yaml
   trigger:
     - main

   variables:
     buildConfiguration: 'Release'
     - group: AppServiceConfig  # Link variable group

   stages:
     - stage: Build
       displayName: Build Stage
       jobs:
         - job: Build
           pool:
             vmImage: 'windows-latest'
           steps:
             - task: UseDotNet@2
               inputs:
                 packageType: 'sdk'
                 version: '7.x'  # Adjust for .NET 6, 8, etc.
                 installationPath: $(Agent.ToolsDirectory)/dotnet

             - task: DotNetCoreCLI@2
               displayName: Restore NuGet Packages
               inputs:
                 command: 'restore'
                 projects: '**/*.csproj'

             - task: DotNetCoreCLI@2
               displayName: Build the Project
               inputs:
                 command: 'build'
                 projects: '**/*.csproj'
                 arguments: '--configuration $(buildConfiguration)'

             - task: DotNetCoreCLI@2
               displayName: Publish the Project
               inputs:
                 command: 'publish'
                 publishWebProjects: true
                 arguments: '--configuration $(buildConfiguration) --output $(Build.ArtifactStagingDirectory)'
                 zipAfterPublish: true

             - task: PublishBuildArtifacts@1
               inputs:
                 pathToPublish: '$(Build.ArtifactStagingDirectory)'
                 artifactName: 'dotnetapp'

     - stage: Deploy
       displayName: Deploy Stage
       dependsOn: Build
       jobs:
         - deployment: DeployToWebApp
           environment: 'production'
           pool:
             vmImage: 'windows-latest'
           strategy:
             runOnce:
               deploy:
                 steps:
                   - download: current
                     artifact: dotnetapp

                   - task: AzureWebApp@1
                     inputs:
                       azureSubscription: $(azureSubscription)
                       appType: 'webApp'
                       appName: $(appName)
                       package: '$(Pipeline.Workspace)/dotnetapp/**/*.zip'
   ```
   - Ensure `.NET 7.x` matches your application’s .NET version (adjust for .NET 6, 8, etc.).
   - The pipeline restores, builds, publishes, and deploys the .NET app to Azure App Service.

---

### 4. Test the CI/CD Flow
1. Commit and push changes to the `main` branch:
   ```bash
   git add .
   git commit -m "Add CI/CD pipeline for .NET app to Azure App Service"
   git push origin main
   ```
2. Monitor the pipeline in **Pipelines** > **Builds**:
   - **Build** stage: Restores, builds, and publishes the .NET app as a zip artifact.
   - **Deploy** stage: Deploys the zip to the Azure App Service.
3. Verify deployment:
   - Access the app at `https://<your-app-service-name>.azurewebsites.net`.

---

## Resources
- [Microsoft Docs: Azure Pipelines](https://learn.microsoft.com/azure/devops/pipelines/?view=azure-devops)
- [Azure DevOps Artifacts | Azure Artifacts In Azure DevOps | Using Azure DevOps Artifacts | Edureka
](https://www.youtube.com/watch?v=o9OpFMQMSHw)
- [YouTube: Azure DevOps CI/CD for .NET](https://www.youtube.com/results?search_query=azure+devops+dotnet+cicd)
- [Medium: Deploying .NET Apps to Azure App Service](https://medium.com/search?q=deploying+asp.net+core+azure+app+service+github+actions)
