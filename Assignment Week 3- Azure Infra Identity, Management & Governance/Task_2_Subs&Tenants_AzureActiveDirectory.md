# Task 1: Subscription, Azure Entra ID, Users, Groups, RBAC Roles, and Custom Roles

**Objective**:  
Observe Azure subscriptions, explore Azure Entra ID, create test users and groups, assign built-in Role-Based Access Control (RBAC) roles, and create and assign a custom role for permission testing.

---

## Step 1: Observe Assigned Subscriptions
1. Go to [Azure Portal](https://portal.azure.com).
2. Navigate to **Home** → **Subscriptions**.
3. Note down:
   - **Subscription Name**
   - **Subscription ID**
   - **Directory (Tenant) ID**
   - **Billing details** (if available)

---

## Step 2: Azure Entra ID Overview or Setup
1. Navigate to **Home** → **Azure Entra ID** (formerly Azure Active Directory).
2. If using a personal Azure account:
   - A default Entra ID tenant is already created. View and manage it here.
3. To create a new Entra tenant (if needed):
   - Go to **Azure Entra ID** → **Manage Tenants** → Click **+ Create**.
   - Select **Azure Active Directory**.
   - Fill in:
     - **Organization Name**
     - **Initial Domain Name**
     - **Region**
   - Click **Create**.

---

## Step 3: Create Test Users and Groups

### Create Test Users
1. Go to **Azure Entra ID** → **Users** → Click **+ New User**.
2. Configure:
   - **Username**: `testuser1`
   - **Name**: `Test User 1`
   - **Password**: Auto-generated or custom
3. Repeat to create additional users (e.g., `testuser2`, `devuser1`).
4. Save each user.

### Create a Group
1. Go to **Azure Entra ID** → **Groups** → Click **+ New Group**.
2. Configure:
   - **Group Type**: Security
   - **Group Name**: `Test-Group`
   - **Members**: Add the test users created above (e.g., `testuser1`, `testuser2`)
3. Click **Create**.

---

## Step 4: Assign a Built-in RBAC Role to a User
1. Navigate to a resource (e.g., a **Resource Group** or **Storage Account**).
2. Go to **Access Control (IAM)** → Click **+ Add** → **Add Role Assignment**.
3. Configure:
   - **Role**: `Reader` (or another built-in role)
   - **Assign access to**: User
   - **Select**: `testuser1`
4. Click **Save**.
5. Test access:
   - Log in to [Azure Portal](https://portal.azure.com) using `testuser1` credentials.
   - Verify access is read-only for the assigned resource.

---

## Step 5: Create a Custom Role and Assign It

### Define Permissions
1. Navigate to **Subscriptions** → **Access Control (IAM)** → Click **+ Add** → **Add Custom Role**.
2. Configure:
   - **Role Name**: `Custom-Read-Monitor`
   - **Description**: Custom role with limited read and monitor permissions
   - **Base Role**: Start from Scratch or clone an existing role (e.g., `Reader`)
3. Set permissions (edit JSON):
   ```json
   {
     "actions": [
       "Microsoft.Resources/subscriptions/resourceGroups/read",
       "Microsoft.Compute/virtualMachines/read",
       "Microsoft.Insights/metrics/read"
     ],
     "notActions": [],
     "dataActions": [],
     "notDataActions": []
   }
   ```
4. Save the custom role.

### Assign Role
1. Go to the target resource or resource group → **Access Control (IAM)** → Click **+ Add** → **Add Role Assignment**.
2. Configure:
   - **Role**: `Custom-Read-Monitor`
   - **Assign access to**: User
   - **Select**: `testuser2`
3. Click **Save**.

### Test Custom Role Access
1. Log in to [Azure Portal](https://portal.azure.com) as `testuser2`.
2. Verify limited access:
   - Can view resource groups, virtual machines, and metrics.
   - Cannot delete or update resources.

---

## Outcome
- Subscription and tenant settings reviewed.
- Azure Entra ID observed or created.
- Test users and groups successfully created.
- Built-in RBAC role assigned and validated.
- Custom role defined, assigned, and tested for restricted access.

---

## Resources
- [Microsoft Learn – Azure CLI Overview](https://learn.microsoft.com/azure/cli/)
- [YouTube: Azure Subscriptions Explained](https://www.youtube.com/results?search_query=azure+subscriptions+explained)
- [Azure Entra ID Documentation](https://learn.microsoft.com/azure/active-directory/)
