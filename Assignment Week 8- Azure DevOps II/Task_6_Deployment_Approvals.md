## Task 6: Apply Pre and Post-Deployment Approvers in the Release Pipeline

**Objective**:  
Set up manual or automatic approval gates in an Azure DevOps release pipeline to enforce quality control, security checks, and compliance before and after deployments to specific environments.

---

## Prerequisites
- An Azure DevOps organization and project (e.g., from Week 7, Task 1).
- A release pipeline with at least one stage (e.g., from Week 7, Task 7).
- Project Administrator or Release Administrator permissions.
- Valid Azure DevOps users or groups to assign as approvers.
- (Optional) A service connection for deployment (e.g., from Week 8, Task 4).

---

## Why Use Deployment Approvals?
- **Quality Control**: Ensure deployments meet standards via stakeholder review.
- **Compliance**: Meet regulatory or organizational requirements.
- **Security**: Prevent unauthorized or untested deployments to critical environments (e.g., staging, production).

---

## Steps to Apply Pre and Post-Deployment Approvals

### Step 1: Navigate to Release Pipelines
1. Go to **Pipelines** > **Releases** in your Azure DevOps project.
2. Click **New pipeline** or select an existing pipeline and click **Edit**.
3. Choose a template (e.g., **Azure App Service deployment**) or start with an **Empty job**.

---

### Step 2: Add a Stage
1. Click **+ Add a stage** and select a template (e.g., **Azure App Service deployment**) or **Empty job**.
2. Name the stage (e.g., `Staging` or `Production`).
3. Configure the stage with deployment tasks (e.g., deploy to an Azure Web App using a service connection).

---

### Step 3: Configure Approvals and Checks
#### Pre-Deployment Approvals
1. Click the **lightning bolt (⚡)** icon on the left side of the stage (pre-deployment conditions).
2. Enable **Pre-deployment approvals**.
3. Add approvers:
   - Select individual users or groups (e.g., `Project Administrators` or a specific team).
   - (Optional) Configure:
     - **Timeout**: Set a duration (e.g., `1440` minutes = 24 hours) for auto-rejection if no response.
     - **Approval count**: Specify the minimum number of approvers (e.g., `1` or `2`).
     - **Email notifications**: Enable to notify approvers.
4. Save the settings.

#### Post-Deployment Approvals
1. Click the **lightning bolt (⚡)** icon on the right side of the stage (post-deployment conditions).
2. Enable **Post-deployment approvals**.
3. Add approvers (similar to pre-deployment).
4. (Optional) Configure timeout and approval count as needed.
5. Save the settings.

#### Advanced Approval Settings
- **Timeout**: Auto-reject or approve if no response within the specified time.
- **Re-approve required**: Enforce re-approval for redeployments to the same stage.
- **Gates** (optional, under Pre-deployment conditions):
  - Add gates like **Query Work Items**, **Monitor Azure Functions**, or **Invoke REST API** for automated checks.
  - Example: Use **Query Work Items** to ensure no open bugs before deployment.

---

### Step 4: Test the Setup
1. Trigger a release (manually or via a CI/CD trigger from Week 7, Task 7).
2. Verify that the pipeline pauses at the stage (e.g., `Staging`) for pre-deployment approval.
3. Approve or reject as an assigned approver (via email notification or the Releases page).
4. After deployment, confirm post-deployment approval is required (if configured).
5. Check the release summary to ensure approvals are logged.

---

### Important Notes
- Only **Project Administrators** or **Release Administrators** can assign approvers.
- Approvers must be valid Azure DevOps users or groups.
- Use a **Service Connection** (e.g., from Week 8, Task 4) for deployment tasks.
- YAML pipelines don’t natively support GUI-based approvals but can simulate them with the `ManualValidation` task:
   ```yaml
   - task: ManualValidation@0
     inputs:
       instructions: 'Please approve before continuing.'
       onTimeout: 'reject'
       timeout: '1h'
   ```
---

## References
- [YouTube: Azure DevOps Pipelines & Approvals](https://www.youtube.com/results?search_query=azure+devops+pipeline+approvals)
- [YouTube: Azure DevOps Test Plans | Test Plans | Test Suites | Edureka
](https://www.youtube.com/watch?v=Cu7zx9u1sOE)
- [Microsoft Docs: Approvals and Gates Overview](https://learn.microsoft.com/azure/devops/pipelines/release/approvals/?view=azure-devops)
