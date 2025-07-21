## Task 4: Apply Branch Filters and Path Filters

**Objective**:  
Implement branch filters and path filters in Azure DevOps to control and customize build triggers and policy enforcement for specific branches and file paths.

---

## Prerequisites
- An Azure DevOps project with a Git repository (e.g., from Week 7, Task 1).
- A pipeline (YAML or Classic) configured in Azure DevOps.
- Administrative permissions to configure pipelines and branch policies.

---

## Steps to Follow

### Step 1: Apply Branch Filters

#### In Pipelines (CI/CD)
1. Go to **Pipelines** in your Azure DevOps project.
2. Select an existing pipeline or create a new one, then click **Edit**.
3. Configure branch filters:
   - **For YAML Pipelines**:
     - Edit the pipeline YAML file (e.g., `azure-pipelines.yml`) to include branch filters:
       ```yaml
       trigger:
         branches:
           include:
             - master
             - dev
           exclude:
             - feature/*
       ```
       - This triggers builds for changes in `master` and `dev` branches but excludes `feature/*` branches.
   - **For Classic Pipelines**:
     - Go to **Triggers** tab > **Continuous Integration**.
     - Under **Branch filters**, add:
       - **Include**: `master`, `dev`
       - **Exclude**: `feature/*`
     - Save the pipeline.

#### In Branch Policies
1. Navigate to **Repos** > **Branches**.
2. Click the three dots (⋮) next to a branch (e.g., `master`) and select **Branch policies**.
3. Under **Build validation**, click **+** to add a pipeline.
4. Select the pipeline and configure:
   - **Branch filters**: Include `master` and/or `dev` to ensure the policy applies to these branches.
   - Set **Build expiration** (e.g., Immediately or After X hours) as needed.
5. Save the policy.

---

### Step 2: Apply Path Filters (in Build Validation Policy)
1. In **Repos** > **Branches**, select **Branch policies** for the `master` branch.
2. Under **Build validation**, edit the existing build policy or add a new one.
3. Scroll to **Path filters**:
   - **Include**: Add paths like `src/`, `docs/` to trigger builds only for changes in these directories.
   - **Exclude**: Add paths like `tests/` to skip builds for changes in these directories.
4. Save the policy.
   - **Example**: Builds trigger only when files in `src/` or `docs/` change, but not for `tests/`.

---

## Use Case Examples
| **Scenario** | **Filter Type** | **Filter Rule** |
|--------------|-----------------|-----------------|
| Run builds only on `master` and `dev` | Branch Filter | Include: `master`, `dev` |
| Ignore changes in documentation folder | Path Filter | Exclude: `docs/` |
| Validate builds only for backend files | Path Filter | Include: `src/backend/` |

---

## Expected Output
- **Branch Filters**: Configured to trigger builds for `master` and `dev` branches, excluding `feature/*`.
- **Path Filters**: Set to include `src/` and `docs/` and exclude `tests/` for build validation.
- **Description**: The filters ensure builds run only for changes in `src/` or `docs/` on the `master` and `dev` branches, optimizing CI/CD for relevant code changes.

---

## Resources
- [YouTube: Azure Boards and Branch Settings](https://www.youtube.com/results?search_query=azure+devops+branch+settings)
- [What is Azure Boards | Azure Boards Tutorial | Azure Tutorial | Intellipaat
](https://www.youtube.com/watch?v=4ah5Tuj0i4s)
- [Microsoft Docs: Branch Permissions & Filters](https://learn.microsoft.com/azure/devops/repos/git/branch-policies?view=azure-devops)
