## Task 2: Use Pipeline Variables in Azure DevOps Pipelines

**Objective**:  
Utilize pipeline variables in Azure DevOps YAML pipelines to manage dynamic values, reduce redundancy, and improve reusability and maintainability of pipeline configurations.

---

## Prerequisites
- An Azure DevOps organization and project (e.g., from Week 7, Task 1).
- A working YAML pipeline (e.g., `azure-pipelines.yml`) in the repository.
- Basic understanding of YAML syntax and Azure Pipelines.
- Permissions to edit pipelines and manage variable groups in the Library.

---

## Step-by-Step Guide

### 1. Define Variables in YAML
1. Create or edit a YAML pipeline file (e.g., `azure-pipelines.yml`) in your repository.
2. Define variables under the `variables` section:
   ```yaml
   trigger:
     - main

   variables:
     appName: 'MyApp'
     environment: 'dev'

   pool:
     vmImage: 'ubuntu-latest'

   steps:
     - script: echo "Deploying $(appName) to $(environment) environment"
       displayName: 'Print deployment info'
   ```
   - Variables `appName` and `environment` are used in the script step with `$(variableName)` syntax.

---

### 2. Use Variable Groups (Library)
1. Navigate to **Pipelines** > **Library** in your Azure DevOps project.
2. Click **+ Variable group** and create a group:
   - **Name**: `MyVariableGroup`
   - **Variables**:
     - `appVersion`: `1.0.3`
     - `environment`: `production`
   - Enable **Allow access to all pipelines**.
3. Save the variable group.
4. Reference the variable group in your YAML pipeline:
   ```yaml
   variables:
     - group: MyVariableGroup

   steps:
     - script: echo "App Version: $(appVersion)"
       displayName: 'Print app version'
   ```

---

### 3. Set Variables in Scripts
1. Use logging commands to set variables dynamically during pipeline execution:
   ```yaml
   steps:
     - script: |
         echo "##vso[task.setvariable variable=buildVersion]1.0.$(Build.BuildId)"
       displayName: 'Set build version'
     - script: echo "Build version is $(buildVersion)"
       displayName: 'Print build version'
   ```
   - The `buildVersion` variable is set using the build ID and used in subsequent steps.

---

### 4. Use Pipeline-Level Parameters (Optional)
1. Define parameters for reusable or configurable pipelines:
   ```yaml
   parameters:
     - name: environment
       type: string
       default: 'dev'

   steps:
     - script: echo "Environment is ${{ parameters.environment }}"
       displayName: 'Print environment'
   ```
   - Parameters allow users to input values when triggering the pipeline manually.

---

### 5. Secret Variables
1. In **Pipelines** > **Library**, add a secret variable to the variable group:
   - Example: `apiToken` (click the lock icon to mark it as secret).
2. Use the secret in your pipeline (cannot be echoed directly for security):
   ```yaml
   variables:
     - group: MyVariableGroup

   steps:
     - script: curl -H "Authorization: Bearer $(apiToken)" https://api.example.com
       displayName: 'Call API with secret token'
   ```
   - Secret variables are accessible but not logged in pipeline output.

---

## Use Case Examples
| **Use Case** | **Variable** | **Purpose** |
|--------------|--------------|-------------|
| Deployment Environment | `environment: 'staging'` | Switch between `dev`, `test`, or `prod` environments. |
| Version Management | `appVersion: '1.0.$(Build.BuildId)'` | Automatic versioning for each build. |
| Reusable Scripts | `dbName: 'orders_db'` | Pass database name to deployment or backup scripts. |
| API Token (Secret) | `apiToken: $(mySecret)` | Secure access to external services or APIs. |

---

## References
- [Microsoft Docs: Pipeline Variables](https://learn.microsoft.com/azure/devops/pipelines/process/variables?view=azure-devops)
- [How to Create a CI/CD Pipeline in Azure DevOps | Azure DevOps Tutorial
](https://www.youtube.com/watch?v=xH5EY7FCFQw&t=77s)
- [YouTube: Video Guide on Azure Pipelines](https://www.youtube.com/results?search_query=azure+devops+pipeline+variables)
