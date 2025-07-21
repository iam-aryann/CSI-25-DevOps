## Task 9: Apply Security on Branches So That Contributors Can Create a Pull Request but Cannot Directly Merge Code to Master

**Objective**:  
Configure branch security and policies in Azure Repos to allow Contributors to raise pull requests (PRs) but prevent them from directly pushing or merging code to the `master` (or `main`) branch, ensuring only Project Administrators or authorized users can merge changes.

---

## Prerequisites
- An Azure DevOps project with a Git repository (e.g., from Week 7, Task 1).
- Administrative permissions to configure branch security and policies.
- Optional: Test user accounts (Contributor and Administrator) to verify permissions.

---

## Steps to Implement

### Go to Your Azure DevOps Project
1. Navigate to **Repos** > **Branches** in your Azure DevOps project.
2. Locate the `master` (or `main`) branch.

---

### Set Branch Security
1. Click the ellipsis (⋮) next to the `master` branch and select **Branch security**.
2. In the security window, configure permissions:
   - **Contributors**:
     - **Contribute**: Set to **Deny** (prevents direct commits to `master`).
     - **Force push (rewrite history & delete branches)**: Set to **Deny**.
     - **Create branch**: Set to **Allow** (allows Contributors to create feature branches).
     - **Create tag**: (Optional) Set to **Deny** or **Allow** based on your needs.
     - **Read**: Set to **Allow** (allows Contributors to view the repository).
     - **Contribute to pull requests**: Set to **Allow** (enables creating and participating in PRs).
   - **Project Administrators**:
     - Ensure **Contribute**, **Force push**, **Create branch**, **Create tag**, and **Manage permissions** are set to **Allow**.
3. Click **Save changes**.

---

### Set Branch Policies (Optional but Recommended)
1. In **Repos** > **Branches**, click the ellipsis (⋮) next to the `master` branch and select **Branch policies**.
2. Enable the following policies:
   - **Require a minimum number of reviewers**:
     - Set to **1** or **2** reviewers.
     - (Optional) Uncheck **Allow requestors to approve their own changes** for stricter control.
   - **Check for linked work items**:
     - Enable to require PRs to be linked to Azure Boards work items.
   - **Limit merge types**:
     - Select allowed types (e.g., **Squash merge**, **No fast-forward**) to enforce consistent merge strategies.
3. (Optional) Add **Build validation** to ensure PRs pass a CI pipeline before merging.
4. Click **Save** to apply the policies.

---

### Test the Setup
1. **As a Contributor**:
   - Attempt to push directly to `master`:
     ```bash
     git clone <repository-url>
     cd <repository>
     echo "Test commit" > test.txt
     git add test.txt
     git commit -m "Direct push to master"
     git push origin master
     ```
     - Expected result: Push fails with a permissions error.
   - Create a feature branch and raise a PR:
     ```bash
     git checkout -b feature-test
     echo "Feature update" > feature.txt
     git add feature.txt
     git commit -m "Add feature update"
     git push origin feature-test
     ```
     - Go to **Repos** > **Pull Requests**, create a PR from `feature-test` to `master`, and verify it can be created.
2. **As an Administrator**:
   - Review and merge the PR in the Azure DevOps UI.
   - Verify the merge succeeds and the changes appear in `master`.

---

## Resources
- [YouTube: Azure DevOps Pipelines and Branch Security](https://www.youtube.com/results?search_query=azure+devops+branch+security)
- [How to Create a CI/CD Pipeline in Azure DevOps | Azure DevOps Tutorial
](https://www.youtube.com/watch?v=xH5EY7FCFQw&t=77s)
- [Microsoft Docs: Branch Permissions](https://learn.microsoft.com/azure/devops/repos/git/branch-permissions?view=azure-devops)
