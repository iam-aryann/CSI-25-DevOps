## Task 7: Apply Triggers in Build and Release Pipelines

**Objective**:  
Implement continuous integration (CI) and continuous deployment (CD) using build and release triggers in Azure DevOps to automate pipeline execution based on code changes or schedules.

---

## Prerequisites
- An Azure DevOps project with a Git repository (e.g., from Week 7, Task 1).
- A YAML or Classic build pipeline configured.
- Permissions to create and manage pipelines in Azure DevOps.
- Optional: Test user accounts to verify pipeline triggers.

---

## Steps to Follow

### Part A: Apply Triggers in Build Pipeline (CI)
1. Navigate to **Pipelines** > **Pipelines** in your Azure DevOps project.
2. Select an existing YAML pipeline or create a new one (e.g., `azure-pipelines.yml`).
3. Add a CI trigger to the YAML file:
   ```yaml
   trigger:
     branches:
       include:
         - main
         - develop
   ```
   - This triggers the pipeline for commits pushed to the `main` or `develop` branches.
4. (Optional) Add a scheduled trigger for nightly builds:
   ```yaml
   schedules:
     - cron: "0 0 * * *"
       displayName: Daily midnight build
       branches:
         include:
           - main
   ```
   - This schedules a build every day at midnight UTC for the `main` branch.
5. Save the YAML file and commit it to the repository.
6. Push a code change to the `main` or `develop` branch to test the CI trigger:
   ```bash
   git commit -m "Test CI trigger"
   git push origin main
   ```
7. Verify the build runs automatically:
   - Go to **Pipelines** > **Builds** and check the build history.

---

### Part B: Apply Triggers in Release Pipeline (CD)
1. Navigate to **Pipelines** > **Releases** in your Azure DevOps project.
2. Click **New pipeline** or edit an existing release pipeline.
3. Under **Artifacts**, click **+ Add** and select the build pipeline (e.g., from Part A) as the source.
4. Enable the Continuous Deployment (CD) trigger:
   - Click the ⚙️ (gear) icon next to the artifact.
   - Toggle **Enable Continuous Deployment** to **ON**.
   - (Optional) Add branch filters to trigger releases only for specific branches (e.g., `main`).
5. Add stages:
   - Create stages like `Dev` and `QA`.
   - Configure deployment tasks for each stage (e.g., deploy to an AKS cluster or Azure App Service).
6. Save the pipeline and create a new release:
   - Click **Create release** and select the artifact version.
   - Trigger a build (from Part A) to verify the release pipeline runs automatically after the build completes.

---

## Deliverables
- **Screenshots**:
  - YAML file showing the `trigger` or `schedules` block for the build pipeline.
  - Release pipeline configuration with the CD trigger enabled.
  - Build and release history showing automatic triggering after a code push.
- **Summary**:  
  CI/CD triggers automate build and deployment processes, improving team productivity by reducing manual intervention and ensuring consistent code quality. Build triggers (CI) run pipelines on code changes or schedules, while release triggers (CD) automate deployments after successful builds.

---

## Resources
- [YouTube: Azure DevOps Repos](https://www.youtube.com/results?search_query=azure+devops+repos)
- [Getting Started with Azure DevOps Repos
](https://www.youtube.com/watch?v=qLhVWJvox7g)
- [Microsoft Docs: Azure DevOps Pipeline Triggers](https://learn.microsoft.com/azure/devops/pipelines/build/triggers?view=azure-devops)
