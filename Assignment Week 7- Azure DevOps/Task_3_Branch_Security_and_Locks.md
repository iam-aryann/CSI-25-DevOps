## Task 3: Apply Branch Security and Locks

**Objective**:  
Apply branch security settings and locks in Azure DevOps to protect critical branches (e.g., `master`) from unauthorized changes or accidental commits.

---

## Prerequisites
- An Azure DevOps project with a Git repository (e.g., from Week 7, Task 1).
- Administrative permissions to configure branch security and locks.
- Optional: Test user accounts (Contributor and Administrator) to verify restrictions.

---

## Steps to Follow

### Step 1: Apply Branch Security
1. Navigate to **Repos** > **Branches** in your Azure DevOps project.
2. Locate the `master` branch.
3. Click the three dots (⋮) next to the `master` branch and select **Branch security**.
4. Configure permissions:
   - **Contributors**:
     - Set **Contribute** to **Deny** (prevents pushing commits).
     - Set **Force push (rewrite history and delete branches)** to **Deny**.
     - (Optional) Set **Create tag** to **Deny**.
     - (Optional) Set **Manage permissions** to **Deny**.
   - **Project Administrators**:
     - Keep **Contribute**, **Force push**, **Create branch**, and **Manage permissions** set to **Allow**.
5. Click **Save changes**.

---

### Step 2: Apply a Branch Lock
1. In **Repos** > **Branches**, locate the `master` branch.
2. Click the padlock icon next to the branch or select **Lock** from the three dots (⋮) menu.
3. Confirm the lock in the dialog box.
   - **What the Lock Does**:
     - Prevents new commits to the branch.
     - Blocks pull request merges.
     - Prohibits forced updates (e.g., `git push --force`).
   - **Use Case**: Ideal for protecting critical or production branches (e.g., `master` or `hotfix`).

---

### Notes / Best Practices
- Use branch locks sparingly for critical branches (e.g., production or hotfix branches).
- For day-to-day control, prefer **Branch Policies** (e.g., requiring reviewers, build validation) over locks to maintain workflow flexibility.
- Regularly review security settings to ensure compliance with team roles.

---

## Expected Output
- **Branch Security Settings**: The `master` branch is restricted to Project Administrators for commits and other actions.
- **Branch Lock**: The `master` branch is locked, preventing any changes (commits, merges, or forced updates).
- **Summary Table**:

| **Branch** | **Security Applied** | **Locked** |
|------------|----------------------|------------|
| master     | ✅ Yes               | ✅ Yes     |

---

## Resources
- [YouTube: Azure Boards, Repos, and Permissions](https://www.youtube.com/results?search_query=azure+devops+branch+security)
- [What is Azure Boards | Azure Boards Tutorial | Azure Tutorial | Intellipaat
](https://www.youtube.com/watch?v=4ah5Tuj0i4s)
- [Microsoft Docs: Branch Policies](https://learn.microsoft.com/azure/devops/repos/git/branch-policies?view=azure-devops)
