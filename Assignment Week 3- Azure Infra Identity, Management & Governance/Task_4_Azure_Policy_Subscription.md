# Task 4: Create and Assign a Policy at Subscription Level

**Objective**:  
Define and assign a policy at the subscription level in Azure to enforce organizational standards, such as restricting resource creation to specific regions, VM SKUs, or enforcing tags.

---

## Pre-requisites
- Access to the [Azure Portal](https://portal.azure.com)
- Sufficient permissions (Owner or Contributor + Policy Contributor role)
- Optional: Azure CLI or ARM templates for advanced scenarios

---

## Steps (Azure Portal)

### 1. Go to “Policy” in Azure Portal
1. Open the [Azure Portal](https://portal.azure.com).
2. Search for and select **Policy**.

### 2. Select the Subscription Scope
1. Under the **Definitions** tab, select your target subscription.
2. All policy definitions and assignments will apply to this scope.

### 3. Create a New Policy Definition
1. In the **Definitions** tab, click **+ Policy definition**.
2. Configure:
   - **Name**: `Allow Only East US`
   - **Definition location**: Select your subscription
   - **Description** (optional): Enforces resources only in East US
   - **Category**: Custom or existing
   - **Policy Rule**:
     ```json
     {
       "if": {
         "not": {
           "field": "location",
           "equals": "eastus"
         }
       },
       "then": {
         "effect": "deny"
       }
     }
     ```
3. Click **Save**.

### 4. Assign the Policy
1. Navigate to the **Assignments** tab.
2. Click **Assign Policy**.
3. Configure:
   - **Scope**: Select your subscription
   - **Policy definition**: Select `Allow Only East US`
   - **Assignment name**: `Restrict to East US`
   - Leave other settings as default (or configure parameters if applicable)
4. Click **Review + create** → **Create**.

---

## Outcome
- A policy was created to enforce restrictions (e.g., limiting resources to East US).
- The policy was assigned at the subscription level.
- Any future non-compliant resource creation will be blocked or flagged.

---

## Resources
- [Anatomy of Azure Policy
](https://www.youtube.com/watch?v=4wGns611G4w)
- [Azure Resource Manager Template Overview](https://learn.microsoft.com/azure/azure-resource-manager/templates/overview)
