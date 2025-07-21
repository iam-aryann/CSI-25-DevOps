# Week 7: Azure DevOps
## Task 1: Create a Project with Different User Groups and Implement Group Policies

**Objective**:  
Create a new project in Azure DevOps, add multiple user groups, and apply specific group-level security policies to control permissions and access levels.

---

## Prerequisites
- An Azure DevOps account (sign up at [dev.azure.com](https://dev.azure.com)).
- A Microsoft/Azure account with sufficient permissions to create projects and manage users.
- Optional: Multiple test user accounts to verify access controls.

---

## Steps to Follow

### Step 1: Sign in to Azure DevOps
1. Go to [dev.azure.com](https://dev.azure.com).
2. Log in using your Microsoft/Azure account credentials.

---

### Step 2: Create a New Project
1. In the Azure DevOps dashboard, click **New Project** (top-right corner).
2. Configure the project:
   - **Project Name**: `MyDevOpsProject` (or any preferred name).
   - **Description**: "A sample project for managing development and testing workflows."
   - **Visibility**: Choose **Private** (default, restricts access to invited users) or **Public** (accessible to anyone with the link).
   - **Version Control**: Select **Git** (recommended for modern workflows) or **TFS** (Team Foundation Server).
   - **Work Item Process**: Choose **Agile** (or another process like Scrum or Basic).
3. Click **Create** to initialize the project.

---

### Step 3: Create User Groups
1. Navigate to **Project Settings** (bottom-left corner of the project dashboard).
2. Go to **Permissions** under the **Security** section.
3. Click **+ New Group** to create the following custom groups:
   - **Developers**: For team members who write and manage code.
   - **Testers**: For team members responsible for testing and quality assurance.
   - **Admins**: For project administrators with full control.
4. Add users to each group:
   - Click on a group, select **Members**, then **Add**.
   - Enter the email addresses of users (Azure AD or Microsoft accounts) or invite new users if needed.

---

### Step 4: Implement Group Policies
1. Assign permissions for each group:
   - Go to **Project Settings** > **Permissions**.
   - Select a group (e.g., `Developers`) and configure permissions:
     - **Developers**:
       - **Code Access**: Allow `Read`, `Contribute`, and `Create Branch` for repositories.
       - **Build Pipelines**: Allow `Edit build pipeline` and `Queue builds`.
       - Deny `Manage test plans` and `Manage test suites`.
     - **Testers**:
       - **Work Items**: Allow `Create`, `Edit`, and `View work items`.
       - **Test Plans**: Allow `Manage test plans` and `Execute tests`.
       - **Repositories**: Allow `Read` only (no `Contribute` or `Create Branch`).
     - **Admins**:
       - Grant **Full Control** (e.g., `Administer project`, `Manage permissions`, `Edit policies`).
2. Configure specific permissions:
   - Go to **Repos** > **Repositories** > **Security** to set repository-level permissions.
   - Go to **Pipelines** > **Builds** > **Security** to set pipeline-level permissions.
   - Example: For the default branch, set **Admins** to allow `Edit policies` and deny for `Developers` and `Testers`.

---

### Step 5: Test Access Control
1. Log in with test user accounts (or simulate using different roles):
   - **Developer Account**: Verify they can push code and edit build pipelines but cannot manage test plans.
   - **Tester Account**: Verify they can create/edit work items and manage test plans but cannot push code or create branches.
   - **Admin Account**: Verify full access, including editing branch policies and managing permissions.
2. Example commands to test access (if using `git`):
   - For a Developer:
     ```bash
     git clone <repository-url>
     git push
     ```
     - Should succeed.
   - For a Tester:
     ```bash
     git push
     ```
     - Should fail with a permissions error.
3. Check test plan access in **Test Plans** section of Azure DevOps UI to confirm restrictions.

---

## Expected Output
- **Project Created**: A new Azure DevOps project (`MyDevOpsProject`) is set up with Git version control and Agile process.
- **User Groups**: Created `Developers`, `Testers`, and `Admins` groups with assigned users.
- **Group Policies**:
  - **Developers**: Can read/write code, edit build pipelines; denied test plan management.
  - **Testers**: Can manage work items and test plans; limited to read-only repository access.
  - **Admins**: Full control over project settings, repositories, and pipelines.
- **Verification**: Access controls confirmed via test user accounts (e.g., Developers cannot edit test plans, Testers cannot push code, Admins can edit branch policies).

---

## Resources
- [YouTube: Azure Boards & Permissions](https://www.youtube.com/results?search_query=azure+boards+permissions)
- [What is Azure Boards | Azure Boards Tutorial | Azure Tutorial | Intellipaat
](https://www.youtube.com/watch?v=4ah5Tuj0i4s)
- [Microsoft Docs: Add Users and Manage Permissions in Azure DevOps](https://learn.microsoft.com/azure/devops/organizations/security/permissions?view=azure-devops)
