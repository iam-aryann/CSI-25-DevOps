## Task 3: Use Variable Groups & Task Groups in Azure DevOps Pipelines with Scoped Stages

**Objective**:  
Modularize and secure Azure DevOps pipelines by using Variable Groups for centralized variable management, Task Groups for reusable steps, and scoped variables for stage-specific configurations.

---

## Prerequisites
- An Azure DevOps organization and project (e.g., from Week 7, Task 1).
- A YAML pipeline (e.g., `azure-pipelines.yml`) in the repository.
- Permissions to manage pipelines, variable groups, and task groups.
- Basic understanding of YAML syntax and Azure Pipelines.

---

## Step-by-Step Guide

### 1. Variable Groups
Variable Groups store shared variables centrally, reusable across multiple pipelines.

#### Create a Variable Group
1. Navigate to **Pipelines** > **Library** in your Azure DevOps project.
2. Click **+ Variable Group**.
3. Configure:
   - **Name**: `GlobalVariables`
   - **Variables**:
     - `envName`: `dev`
     - `region`: `eastus`
   - Enable **Allow access to all pipelines**.
4. Save the variable group.

#### Use Scoped Variable Groups in YAML
1. Create additional variable groups for stage-specific variables:
   - **Name**: `BuildStageVars`
     - Variables: `buildConfig: Release`
   - **Name**: `DeployStageVars`
     - Variables: `deployEnv: Production`
2. Reference variable groups in the YAML pipeline with stage scoping:
   ```yaml
   variables:
     - group: GlobalVariables  # Shared across all stages

   stages:
     - stage: Build
       variables:
         - group: BuildStageVars  # Scoped to Build stage
       jobs:
         - job: BuildJob
           steps:
             - script: echo "Environment: $(envName)"
               displayName: 'Print environment'
             - script: echo "Build Config: $(buildConfig)"
               displayName: 'Print build config'

     - stage: Deploy
       variables:
         - group: DeployStageVars  # Scoped to Deploy stage
       jobs:
         - job: DeployJob
           steps:
             - script: echo "Deploying to: $(region)"
               displayName: 'Print region'
             - script: echo "Deploying to: $(deployEnv)"
               displayName: 'Print deploy environment'
   ```

---

### 2. Task Groups
Task Groups bundle pipeline tasks for reusability and consistency across pipelines.

#### Create a Task Group
1. In a pipeline editor (Classic or YAML):
   - Add tasks (e.g., build and deploy tasks like `mvn package` or `az webapp deploy`).
   - Select multiple tasks, right-click, and choose **Create task group**.
2. Configure the task group:
   - **Name**: `DeployTaskGroup`
   - **Parameters**:
     - `artifactName`: Default value `webapp`
     - `environment`: Default value `prod`
3. Save and publish the task group.

#### Use a Task Group in a Pipeline
1. Add the task group to your YAML pipeline:
   ```yaml
   jobs:
     - job: DeployJob
       steps:
         - task: DeployTaskGroup@1
           inputs:
             artifactName: 'webapp'
             environment: 'prod'
   ```

---

### 3. Set Scope for Variables per Stage
1. Define inline variables scoped to specific stages in the YAML pipeline:
   ```yaml
   stages:
     - stage: Build
       variables:
         buildConfig: 'Release'
       jobs:
         - job: Compile
           steps:
             - script: echo "Building in $(buildConfig)"
               displayName: 'Build step'

     - stage: Deploy
       variables:
         deployEnv: 'Production'
       jobs:
         - job: DeployToProd
           steps:
             - script: echo "Deploying to $(deployEnv)"
               displayName: 'Deploy step'
   ```

---

### 4. Secret Variables in Variable Groups
1. In **Pipelines** > **Library**, add secret variables to a variable group (e.g., `GlobalVariables`):
   - Variables: `clientId`, `clientSecret`, `tenantId` (mark as secret by clicking the lock icon).
2. Use secret variables in the pipeline (cannot be echoed for security):
   ```yaml
   variables:
     - group: GlobalVariables

   steps:
     - script: az login --service-principal -u $(clientId) -p $(clientSecret) --tenant $(tenantId)
       displayName: 'Azure login with service principal'
   ```
---

## References
- [Microsoft Docs: Variable Groups](https://learn.microsoft.com/azure/devops/pipelines/library/variable-groups?view=azure-devops)
- [YouTube: Azure DevOps Test Plans | Test Plans | Test Suites | Edureka
](https://www.youtube.com/watch?v=Cu7zx9u1sOE)
- [Microsoft Docs: Task Groups](https://learn.microsoft.com/azure/devops/pipelines/library/task-groups?view=azure-devops)
- [YouTube: Azure DevOps Test Plans & Library](https://www.youtube.com/results?search_query=azure+devops+variable+groups)
