# Week 7: Azure DevOps
## Task 5: Apply a Pull Request

**Objective**:  
Learn to create and manage a pull request (PR) in Azure DevOps to ensure code review and quality checks before merging changes into protected branches (e.g., `master` or `main`).

---

## Prerequisites
- An Azure DevOps project with a Git repository (e.g., from Week 7, Task 1).
- Branch policies configured for the `master` branch (e.g., from Week 7, Task 2 or 3).
- Permissions to create branches, push changes, and create pull requests.
- Optional: Test user accounts for reviewers to simulate the review process.

---

## Steps to Follow

### Step 1: Create a New Branch
1. Navigate to **Repos** > **Files** in your Azure DevOps project.
2. Click the branch dropdown (showing `master` or `main`) and select **+ New branch**.
3. Configure:
   - **Name**: `feature-xyz`
   - **Based on**: `master`
4. Click **Create branch**.

---

### Step 2: Make Changes in the New Branch
1. In the **Files** view, ensure you’re on the `feature-xyz` branch.
2. Add or edit a file:
   - Example: Create a file named `feature.txt` with content like `Added feature XYZ functionality`.
   - Alternatively, edit an existing file (e.g., `README.md`).
3. Commit the changes:
   - Enter a commit message (e.g., `Added feature xyz`).
   - Click **Commit** to save changes to the `feature-xyz` branch.

---

### Step 3: Create a Pull Request (PR)
1. Go to **Repos** > **Pull Requests**.
2. Click **New Pull Request**.
3. Configure the PR:
   - **Source branch**: `feature-xyz`
   - **Target branch**: `master` (or `main`)
   - **Title**: `Add feature XYZ`
   - **Description**: `Implements feature XYZ with changes in feature.txt`
   - **Reviewers**: Add one or more team members (e.g., Project Administrators or other users).
   - **Work Items**: Link to a work item (optional, if using Azure Boards).
4. Click **Create**.

---

### Step 4: Review and Complete the PR
1. Notify reviewers to approve the PR (or simulate approval if using a test account).
2. Once approved:
   - Click **Complete** in the PR view.
   - Choose merge options:
     - **Merge type**: Select **Merge** (default) or **Squash commits** for a cleaner history.
     - **Delete source branch**: Check to delete `feature-xyz` after merging (optional).
   - Click **Complete Merge**.
3. Confirm the merge is successful (the PR status will update to **Completed**).

---

### Optional Enhancements
- **Required Reviewers**: In **Repos** > **Branches** > **Branch policies** for `master`, add required reviewers to enforce approvals.
- **Build Validation**: Add a build pipeline under **Branch policies** > **Build validation** to ensure PRs pass automated tests.
- **Auto-complete**: Enable auto-complete in the PR settings to automatically merge once all policies (e.g., approvals, builds) are satisfied.

---

## Resources
- [YouTube: Azure DevOps Pull Request Tutorial](https://www.youtube.com/results?search_query=azure+devops+pull+request+tutorial)
- [Getting Started with Azure DevOps Repos
](https://www.youtube.com/watch?v=qLhVWJvox7g)
- [Microsoft Docs: Azure DevOps Pull Requests](https://learn.microsoft.com/azure/devops/repos/git/pull-requests?view=azure-devops)
