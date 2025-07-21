## Task 6: Apply Branch Policy and Branch Security

**Objective**:  
Enforce development standards and secure code by configuring branch policies (e.g., required reviewers, build validation) and branch-level security permissions in Azure DevOps to protect critical branches like `main`.

---

## Prerequisites
- An Azure DevOps project with a Git repository (e.g., from Week 7, Task 1).
- Administrative permissions to configure branch policies and security settings.
- Optional: A pipeline configured for build validation (e.g., from Week 7, Task 4).
- Optional: Test user accounts for Contributors and Administrators to verify permissions.

---

## Steps to Follow

### Part A: Apply Branch Policies
1. Navigate to **Project** > **Repos** > **Branches** in your Azure DevOps project.
2. Hover over the `main` (or `master`) branch, click the three dots (⋮), and select **Branch policies**.
3. Configure the following policies:
   - **Require a minimum number of reviewers**:
     - Set to **1** or **2** reviewers.
     - (Optional) Check **Allow requestors to approve their own changes** (disable for stricter control).
   - **Check for linked work items**:
     - Enable **Require** to ensure pull requests (PRs) are linked to work items in Azure Boards.
   - **Limit merge types**:
     - Select allowed merge types (e.g., **Squash merge**, **Rebase and fast-forward**, or **Merge**).
   - **Build Validation** (Optional):
     - Click **+** under **Build validation**.
     - Select an existing pipeline (e.g., a CI pipeline from Week 7, Task 4).
     - Configure to run automatically for PRs targeting the `main` branch.
4. Click **Save** to apply the policies.

**Output**:  
- Screenshot of the **Branch policies** setup screen showing reviewer requirements, work item linking, merge types, and build validation (if configured).

---

### 🔹 Part B: Apply Branch Security
1. Navigate to **Project** > **Repos** > **Branches**.
2. Click the three dots (⋮) next to the `main` branch and select **Branch security**.
3. Configure permissions for user groups:
   - **Contributors**:
     - Set **Contribute** to **Deny** (forces changes via pull requests).
     - Set **Force push (rewrite history and delete branches)** to **Deny**.
     - Set **Delete** to **Deny**.
     - (Optional) Set **Manage permissions** to **Deny**.
   - **Project Administrators**:
     - Set **Contribute**, **Force push**, **Create branch**, and **Manage permissions** to **Allow**.
4. Click **Save changes**.

---

## Resources
- [YouTube: Azure DevOps Repos Branch Policies](https://www.youtube.com/results?search_query=azure+devops+branch+policies)
- [Getting Started with Azure DevOps Repos
](https://www.youtube.com/watch?v=qLhVWJvox7g)
- [Microsoft Docs: Azure DevOps Branch Permissions](https://learn.microsoft.com/azure/devops/repos/git/branch-permissions?view=azure-devops)
