## Task 10: Use Work Items in Pipelines

**Objective**:  
Integrate Work Items into Azure Pipelines to ensure traceability from code commits to builds and deployments, linking each pipeline run to specific user stories, tasks, bugs, or features for end-to-end traceability.

---

## Prerequisites
- An Azure DevOps project with a Git repository and a pipeline (e.g., from Week 7, Task 7).
- Access to Azure Boards for creating work items.
- Permissions to create work items, commit code, and configure pipelines.
- Optional: Test user accounts to simulate commits and pipeline runs.

---

## Steps to Implement

### Create Work Items
1. Navigate to **Boards** > **Work Items** in your Azure DevOps project.
2. Click **+ New Work Item** and select a type (e.g., **User Story** or **Task**).
3. Fill in:
   - **Title**: `Fix UI bug on login page`
   - **Description**: `Resolve alignment issue on login page for better user experience`
   - **Assigned To**: Assign to a team member (e.g., yourself or a test user).
4. Click **Save** and note the Work Item ID (e.g., `#123`).

---

### Link Work Item to a Commit
1. In your local Git repository:
   - Make changes to a file (e.g., create/edit `login-fix.css`).
   - Commit with a message referencing the Work Item ID:
     ```bash
     git add login-fix.css
     git commit -m "Fix: UI bug on login page. Work Item #123"
     ```
     - Replace `#123` with the actual Work Item ID.
2. Push the commit to Azure Repos:
   ```bash
   git push origin feature-ui-fix
   ```

---

### Enable Work Item Integration in Pipelines
1. Go to **Pipelines** > **Pipelines** and select your pipeline (e.g., a YAML or Classic pipeline).
2. Click **Edit**.
3. Navigate to the **Options** tab (top right in Classic pipelines or edit the YAML directly).
4. Enable work item integration:
   - **Classic Pipeline**:
     - Check **Associate work items with commits and builds** under **Integrate work items with builds**.
   - **YAML Pipeline**:
     - Ensure the pipeline triggers on the branch with the commit (e.g., `feature-ui-fix` or `main`).
     - Work item association is automatic if the commit message includes the Work Item ID.
5. Save the pipeline configuration.

---

### Run the Pipeline
1. Trigger the pipeline:
   - Manually: Click **Run pipeline** in the UI.
   - Automatically: If a CI trigger is set (e.g., from Week 7, Task 7), push to the branch (e.g., `feature-ui-fix`).
2. Wait for the pipeline to complete.

---

### Verify the Work Item Link
1. Go to **Pipelines** > **Builds** and open the completed build.
2. Check the **Related Work Items** section in the build summary.
   - The Work Item (e.g., `#123`) should be listed with a link to the Azure Boards item.
3. Navigate to **Boards** > **Work Items**, open the Work Item (`#123`), and verify the build is listed under **Links** or **Development**.

---

### Test the Setup
1. Create multiple commits linked to different Work Items:
   ```bash
   git commit -m "Update login page styles. Work Item #124"
   git commit -m "Fix button alignment. Work Item #125"
   git push origin feature-ui-fix
   ```
2. Run the pipeline and verify that each build links to the corresponding Work Items in the build summary.
3. Check traceability in **Boards** > **Work Items** to confirm commits and builds are linked to the correct Work Items.

---

## Resources
- [YouTube: Azure DevOps Pipeline Integration](https://www.youtube.com/results?search_query=azure+devops+pipeline+integration)
- [How to Create a CI/CD Pipeline in Azure DevOps | Azure DevOps Tutorial
](https://www.youtube.com/watch?v=xH5EY7FCFQw&t=77s)
- [Microsoft Docs: About Work Items](https://learn.microsoft.com/azure/devops/boards/work-items/about-work-items?view=azure-devops)
