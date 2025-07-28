## Task 10: Create a CI/CD Pipeline to Build a React Application and Deploy It to an Azure Virtual Machine

**Objective**:  
Automate the process of building a React.js application and deploying it to an Azure Virtual Machine (VM) via SSH using an Azure DevOps CI/CD pipeline.

---

## Prerequisites
- An Azure subscription with a Linux VM (Ubuntu/Debian preferred) configured with:
  - Public IP address.
  - SSH access (username and password/private key).
  - Nginx or Apache installed to serve the React app.
- An Azure DevOps project with a Git repository containing a React application.
- An SSH service connection in Azure DevOps.
- Permissions to manage pipelines and service connections.

---

## Setup SSH Service Connection in Azure DevOps
1. Go to **Project Settings** > **Service connections**.
2. Click **+ New service connection** and select **SSH**.
3. Configure:
   - **Host name**: Public IP address of the Azure VM.
   - **Port**: `22`.
   - **Username**: VM user (e.g., `azureuser`).
   - **Password or Private Key**: Provide the SSH password or private key.
   - **Service connection name**: `react-ssh-connection`.
4. Click **Save**.

---

## React App Structure
```
my-react-app/
├── public/
├── src/
├── package.json
├── .gitignore
└── azure-pipelines.yml
```

---

## Pipeline: `azure-pipelines.yml`
1. Create a file named `azure-pipelines.yml` in your repository:
   ```yaml
   trigger:
     branches:
       include:
         - main

   variables:
     vmTargetPath: '/var/www/reactapp'  # Target directory in VM
     sshServiceConnection: 'react-ssh-connection'  # Name of SSH connection

   stages:
     - stage: Build
       displayName: Build React App
       jobs:
         - job: Build
           pool:
             vmImage: 'ubuntu-latest'
           steps:
             - task: NodeTool@0
               inputs:
                 versionSpec: '18.x'
               displayName: 'Install Node.js'

             - script: |
                 npm install
                 npm run build
               displayName: 'Install & Build React App'

             - task: CopyFiles@2
               inputs:
                 sourceFolder: '$(System.DefaultWorkingDirectory)/build'
                 contents: '**'
                 targetFolder: '$(Build.ArtifactStagingDirectory)/build'

             - task: PublishBuildArtifacts@1
               inputs:
                 pathToPublish: '$(Build.ArtifactStagingDirectory)/build'
                 artifactName: 'reactbuild'

     - stage: Deploy
       displayName: Deploy to Azure VM
       dependsOn: Build
       jobs:
         - deployment: DeployReact
           environment: 'production'
           pool:
             vmImage: 'ubuntu-latest'
           strategy:
             runOnce:
               deploy:
                 steps:
                   - download: current
                     artifact: reactbuild

                   - task: CopyFilesOverSSH@0
                     inputs:
                       sshEndpoint: '$(sshServiceConnection)'
                       sourceFolder: '$(Pipeline.Workspace)/reactbuild'
                       contents: '**'
                       targetFolder: '$(vmTargetPath)'
                       cleanTargetFolder: true
                       overwrite: true

                   - task: SSH@0
                     inputs:
                       sshEndpoint: '$(sshServiceConnection)'
                       runOptions: 'commands'
                       commands: |
                         sudo chown -R www-data:www-data $(vmTargetPath)
                         sudo systemctl restart nginx
                     displayName: 'Restart Nginx'
   ```

---

## On Azure VM
1. **Install Nginx**:
   ```bash
   sudo apt update
   sudo apt install nginx -y
   ```
2. **Configure Nginx**:
   - Edit `/etc/nginx/sites-available/default`:
     ```nginx
     server {
         listen 80 default_server;
         root /var/www/reactapp;
         index index.html index.htm;

         server_name _;

         location / {
             try_files $uri /index.html;
         }
     }
     ```
   - Verify and restart Nginx:
     ```bash
     sudo nginx -t
     sudo systemctl restart nginx
     ```

---

## Test the CI/CD Flow
1. Commit and push changes to the `main` branch:
   ```bash
   git add .
   git commit -m "Add CI/CD pipeline for React app to Azure VM"
   git push origin main
   ```
2. Monitor the pipeline in **Pipelines** > **Builds**:
   - **Build** stage: Installs Node.js, builds the React app, and publishes the build artifact.
   - **Deploy** stage: Copies the build to the VM via SSH and restarts Nginx.
3. Verify deployment:
   - Access the app at `http://<your-vm-ip>`.

---

## Resources
- [Microsoft Docs: Azure Pipelines](https://learn.microsoft.com/azure/devops/pipelines/?view=azure-devops)
- [Azure DevOps Artifacts | Azure Artifacts In Azure DevOps | Using Azure DevOps Artifacts | Edureka
](https://www.youtube.com/watch?v=o9OpFMQMSHw)
- [YouTube: Azure DevOps CI/CD for React](https://www.youtube.com/results?search_query=azure+devops+react+cicd)
- [Medium: Deploying React Apps to Azure](https://medium.com/search?q=deploy+react+app+azure+devops)
