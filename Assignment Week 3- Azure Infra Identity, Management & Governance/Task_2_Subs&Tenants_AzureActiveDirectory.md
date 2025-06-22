# Task 2: Azure Entra ID Setup, User & Group Management, RBAC & Custom Roles

**Objective**:  
Set up or observe Azure Entra ID, create users and groups, assign built-in RBAC roles, and create and assign a custom role for permission management, using the Azure Portal unless specified otherwise.

---

## Step 1: Observe Assigned Subscriptions
1. Go to [Azure Portal](https://portal.azure.com) → **Subscriptions**.
2. Review:
   - **Subscription Name**
   - **Subscription ID**
   - **Directory/Tenant ID**
   - **Billing settings** and Owner/Contributor roles (optional)

---

## Step 2: Observe or Create Azure Entra ID

### To Observe
1. Navigate to **Home** → **Azure Entra ID**.
2. Explore:
   - **Overview**: Tenant ID, Primary Domain, License, Users
   - **Users**, **Groups**, **Roles**, and **Enterprise Apps**

### To Create Your Own (If not present)
1. Navigate to **Azure Entra ID** → **Manage tenants** → Click **+ Create**.
2. Select **Azure Active Directory**.
3. Configure:
   - **Org Name**: `DevOrg`
   - **Initial Domain**: `devorg.onmicrosoft.com`
   - **Region**: Your current location
4. Click **Review + Create** → **Create**.

---

## Step 3: Create Test Users and Groups

### Create Users
1. Go to **Azure Entra ID** → **Users** → Click **+ New User**.
2. Select **Create New User**.
3. Configure:
   - **User name**: `test.user1`
   - **Name**: `Test User 1`
   - **Password**: Auto-generate or set manually
4. Click **Create**.
5. Repeat for additional users (e.g., `test.user2`).

### Create a Group
1. Navigate to **Azure Entra ID** → **Groups** → Click **+ New Group**.
2. Configure:
   - **Group type**: Security
   - **Group name**: `Dev-Team`
   - **Members**: Add previously created users (e.g., `test.user1`, `test.user2`)
3. Click **Create**.

---

## Step 4: Assign a Built-in RBAC Role to User

### Example: Assign Reader Role
1. Go to a resource group (e.g., `RG-Demo`).
2. Navigate to **Access Control (IAM)** → **Role assignments** → Click **+ Add** → **Add role assignment**.
3. Configure:
   - **Role**: `Reader`
   - **Assign to**: User
   - **Select**: `test.user1`
4. Click **Save**.

### Test
1. Log in to [Azure Portal](https://portal.azure.com) as `test.user1`.
2. Navigate to the assigned resource group.
3. Verify read-only access (can view but cannot edit or delete resources).

---

## Step 5: Create and Assign a Custom Role

### Create Custom Role
1. Go to **Subscriptions** → **Access Control (IAM)** → **Roles** → Click **+ Add** → **Add Custom Role**.
2. Configure:
   - **Choose**: Start from Scratch
   - **Name**: `Monitor-Only`
   - **Description**: Custom role for viewing only monitor-related settings
3. Define permissions (edit JSON):
   ```json
   {
     "actions": [
       "Microsoft.Insights/metrics/read",
       "Microsoft.Insights/logs/read",
       "Microsoft.Resources/subscriptions/resourceGroups/read"
     ],
     "notActions": [],
     "dataActions": [],
     "notDataActions": []
   }
   ```
4. Click **Next** → **Assignable Scopes** → **+ Add** → Select the subscription.
5. Click **Review + Create** → **Create**.

### Assign the Role
1. Go to a VM or Resource Group → **Access Control (IAM)** → Click **+ Add** → **Add Role Assignment**.
2. Configure:
   - **Role**: `Monitor-Only`
   - **Assign to**: User
   - **Select**: `test.user2`
3. Click **Save**.

### Test
1. Log in to [Azure Portal](https://portal.azure.com) as `test.user2`.
2. Verify access:
   - Can view metrics, logs, and resource groups.
   - Cannot perform other actions (e.g., edit or delete resources).

---

## Outcome
- Subscription and Azure Entra ID understood or set up.
- Test users and groups successfully created and managed.
- Built-in RBAC role (`Reader`) assigned and validated.
- Custom RBAC role (`Monitor-Only`) created and tested.

---

## Resources
- [Azure Active Directory | Microsoft Azure Tutorial for Beginners | Azure 70-533 Training | Edureka
](https://www.youtube.com/watch?v=OQwQmikCLs4)
- [Microsoft Learn – Azure Role-Based Access Control](https://learn.microsoft.com/azure/role-based-access-control/)
- [Azure Entra ID Documentation](https://learn.microsoft.com/azure/active-directory/)
