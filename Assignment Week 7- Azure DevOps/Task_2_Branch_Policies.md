## Task 2: Apply Branch Policies to Restrict Master Branch Access to Only Project Administrators

**Objective**:  
Configure branch policies in Azure DevOps to restrict push and commit access to the `master` branch to only Project Administrators, while denying Contributors these permissions.

---

## Prerequisites
- An Azure DevOps project with a Git repository (e.g., from Week 7, Task 1).
- Access to the Azure DevOps organization with administrative permissions.
- Optional: Test user accounts (Contributor and Administrator) to verify access restrictions.

---

## Steps to Follow

### Step 1: Navigate to Repos
1. In your Azure DevOps project, go to **Repos** > **Branches** in the left-hand menu.

---

### Step 2: Open Branch Security
1. Locate the `master` branch in the list of branches.
2. Click the three dots (⋮) next to the `master` branch.
3. Select **Branch security** from the dropdown menu.

---

### Step 3: Edit Permissions
1. In the **Branch security** settings, you’ll see a list of security groups (e.g., `Contributors`, `Project Administrators`).

---

### Step 4: Modify Access for Contributors
1. Select the **Contributors** group.
2. Set the following permissions to **Deny**:
   - **Contribute**: Prevents pushing commits to the `master` branch.
   - **Force push (rewrite history and delete branches)**: Prevents rewriting history or deleting the branch.
   - (Optional) **Create tag**: Prevents creating tags.
   - (Optional) **Manage permissions**: Prevents Contributors from modifying branch security settings.

---

### Step 5: Ensure Admins Have Access
1. Select the **Project Administrators** group.
2. Ensure the following permissions are set to **Allow**:
   - **Contribute**: Allows pushing commits.
   - **Force push**: Allows rewriting history or deleting branches.
   - **Create branch**: Allows creating new branches.
   - **Manage permissions**: Allows modifying branch security settings.

---

### Step 6: Save Changes
1. Click **Save changes** at the bottom of the **Branch security** settings.

---

### Step 7: Test Access (Optional)
1. Using a Contributor account, attempt to push a commit to the `master` branch:
   ```bash
   git clone <repository-url>
   cd <repository>
   echo "Test commit" > test.txt
   git add test.txt
   git commit -m "Test commit"
   git push origin master
   ```
   - Expected result: The push should fail with a permissions error.
2. Using a Project Administrator account, repeat the push:
   - Expected result: The push should succeed.

---

## Expected Output
- **Branch Security Settings**: The `master` branch is restricted to only Project Administrators for push and commit operations.
- **Permission Matrix**:

| **Group**              | **Contribute** | **Force Push** | **Manage Permissions** |
|------------------------|----------------|----------------|-----------------------|
| Contributors           | ❌ Deny        | ❌ Deny        | ❌ Deny               |
| Project Administrators | ✅ Allow       | ✅ Allow       | ✅ Allow              |

---

## Resources
- [YouTube: Azure Boards, Repos, and Permissions (Branch Security)](https://www.youtube.com/results?search_query=azure+devops+branch+security)
- [What is Azure Boards | Azure Boards Tutorial | Azure Tutorial | Intellipaat
](https://www.youtube.com/watch?v=4ah5Tuj0i4s)
- [Microsoft Docs: Set Branch Permissions](https://learn.microsoft.com/azure/devops/repos/git/branch-permissions?view=azure-devops)
