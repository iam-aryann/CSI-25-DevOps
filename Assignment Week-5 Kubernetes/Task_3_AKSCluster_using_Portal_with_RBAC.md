## Task 3: Deploy an AKS Cluster Using Azure Portal, Access Dashboard, and Create Roles for Multiple Users

**Objective**:  
Deploy an Azure Kubernetes Service (AKS) cluster using the Azure Portal, access the Kubernetes dashboard, and configure Role-Based Access Control (RBAC) roles for different users.

---

## Prerequisites
- Access to the [Azure Portal](https://portal.azure.com)
- Azure subscription with sufficient permissions (Owner or Contributor)
- Azure CLI installed (optional for dashboard access)
- `kubectl` installed (optional for applying RBAC configurations)

---

## Steps to Complete the Task

### Step 1: Deploy an AKS Cluster via Azure Portal
1. Go to [Azure Portal](https://portal.azure.com).
2. Search for **Kubernetes services** → Click **Create** → **Create a Kubernetes cluster**.
3. Configure the **Basics** tab:
   - **Subscription**: Select your Azure subscription.
   - **Resource group**: Create a new one or select an existing one (e.g., `aks-rg`).
   - **Kubernetes cluster name**: `aks-cluster`
   - **Region**: Choose a nearby region (e.g., Central India).
   - **Kubernetes version**: Use the default or select the latest stable version.
4. Configure the **Node Pools** tab:
   - **Node size**: `Standard_DS2_v2`
   - **Node count**: 1 or 2
5. Configure the **Authentication** tab:
   - Select **System-assigned managed identity**.
   - Enable **Role-based access control (RBAC)**.
6. Configure the **Networking** tab:
   - Choose **Azure CNI** (or leave as default).
   - Enable **HTTP Application Routing** (optional for public dashboard access).
7. Click **Review + Create** → **Create**.
8. Wait 5–10 minutes for the AKS cluster deployment to complete.

---

### Step 2: Access the Kubernetes Dashboard
*Note*: The Kubernetes Dashboard is not enabled by default in AKS.

1. **Enable Kubernetes Dashboard Add-on** (if available):
   - Go to the AKS resource → **Settings** → **Configurations**.
   - Under **Add-ons**, enable the **Kubernetes Dashboard** if listed.

2. **Manually Access the Dashboard** (if add-on is unavailable):
   - Install `kubectl` locally if not already installed:
     ```bash
     az aks install-cli
     ```
   - Get cluster credentials:
     ```bash
     az aks get-credentials --resource-group <resource-group-name> --name aks-cluster
     ```
   - Open the dashboard via a local proxy:
     ```bash
     az aks browse --resource-group <resource-group-name> --name aks-cluster
     ```
   - This opens the Kubernetes dashboard at [http://127.0.0.1:8001](http://127.0.0.1:8001) in your browser.

---

### Step 3: Create Roles and Assign to Users (RBAC)

1. **Create a Role** (read-only access to pods):
   - Create a file named `role.yaml`:
     ```yaml
     apiVersion: rbac.authorization.k8s.io/v1
     kind: Role
     metadata:
       namespace: default
       name: pod-reader
     rules:
     - apiGroups: [""]
       resources: ["pods"]
       verbs: ["get", "watch", "list"]
     ```

2. **Create a RoleBinding**:
   - Create a file named `rolebinding.yaml`:
     ```yaml
     apiVersion: rbac.authorization.k8s.io/v1
     kind: RoleBinding
     metadata:
       name: read-pods-binding
       namespace: default
     subjects:
     - kind: User
       name: "username@example.com" # Replace with actual Azure AD user email
       apiGroup: rbac.authorization.k8s.io
     roleRef:
       kind: Role
       name: pod-reader
       apiGroup: rbac.authorization.k8s.io
     ```

3. **Apply Roles**:
   - Apply the YAML files using `kubectl`:
     ```bash
     kubectl apply -f role.yaml
     kubectl apply -f rolebinding.yaml
     ```

4. **Verify RBAC**:
   - Log in as the Azure AD user specified in the RoleBinding.
   - Use `kubectl` to test access:
     ```bash
     kubectl get pods
     ```
   - The user should have read-only access to pods in the `default` namespace but no permissions for other actions (e.g., create or delete).

---

## Outcome
- An AKS cluster (`aks-cluster`) is deployed via the Azure Portal.
- The Kubernetes Dashboard is accessible locally at [http://127.0.0.1:8001](http://127.0.0.1:8001).
- Custom RBAC roles (`pod-reader`) and bindings are configured for Azure AD users, ensuring secure, role-based access to cluster resources.

---

## Resources
- [YouTube: Logging and Monitoring in AKS](https://www.youtube.com/results?search_query=logging+and+monitoring+in+aks)
- [How to monitor Kubernetes workloads with Azure Monitor for Containers
](https://www.youtube.com/watch?v=XEdwGvS2AwA)
- [AKS Documentation](https://learn.microsoft.com/azure/aks/)
- [Kubernetes RBAC Documentation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
