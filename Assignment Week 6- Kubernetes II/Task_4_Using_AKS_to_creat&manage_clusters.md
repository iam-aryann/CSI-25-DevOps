## Task 4: Managing Kubernetes with Azure Kubernetes Service (AKS)

**Objective**:  
Learn to manage Kubernetes clusters using Azure Kubernetes Service (AKS), including creation, scaling, and upgrading operations.

---

## Prerequisites
- Access to the [Azure Portal](https://portal.azure.com) with an Azure subscription.
- Azure CLI installed (verify with `az --version`).
- `kubectl` installed (verify with `kubectl version --client`).
- Sufficient permissions (Owner or Contributor role) in the Azure subscription.

---

## Steps to Complete the Task

### 1. Creating an AKS Cluster

#### Using Azure Portal
1. Go to the [Azure Portal](https://portal.azure.com).
2. Search for **Kubernetes Services** → Click **+ Create** → **Create a Kubernetes cluster**.
3. Configure:
   - **Subscription**: Select your Azure subscription.
   - **Resource Group**: Create or select an existing one (e.g., `myResourceGroup`).
   - **Cluster Name**: `myAKSCluster`.
   - **Region**: Choose a region (e.g., `eastus`).
   - **Node Pool Settings**:
     - **Node Size**: `Standard_DS2_v2` (or default).
     - **Node Count**: 2.
   - Enable **Role-based access control (RBAC)** and **System-assigned managed identity**.
4. Click **Review + Create** → **Create**.
5. Wait 5–10 minutes for the cluster to deploy.

#### Using Azure CLI
1. Create a resource group:
   ```bash
   az group create --name myResourceGroup --location eastus
   ```
2. Create the AKS cluster:
   ```bash
   az aks create \
     --resource-group myResourceGroup \
     --name myAKSCluster \
     --node-count 2 \
     --enable-addons monitoring \
     --generate-ssh-keys
   ```

---

### 2. Connect to AKS Cluster
1. Configure `kubectl` to connect to the AKS cluster:
   ```bash
   az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
   ```
2. Verify the connection:
   ```bash
   kubectl get nodes
   ```
   - You should see the nodes (e.g., 2 nodes) in the `Ready` state.

---

### 3. Scaling AKS Clusters

#### Manual Scaling
1. Scale the cluster to 4 nodes:
   ```bash
   az aks scale \
     --resource-group myResourceGroup \
     --name myAKSCluster \
     --node-count 4
   ```
2. Verify the new node count:
   ```bash
   kubectl get nodes
   ```

#### Auto-scaling (Optional)
1. Enable cluster autoscaler:
   ```bash
   az aks update \
     --resource-group myResourceGroup \
     --name myAKSCluster \
     --enable-cluster-autoscaler \
     --min-count 2 \
     --max-count 5
   ```
   - This configures the cluster to automatically scale between 2 and 5 nodes based on workload demand.

---

### 4. Upgrading an AKS Cluster
1. Check available Kubernetes versions:
   ```bash
   az aks get-upgrades \
     --resource-group myResourceGroup \
     --name myAKSCluster
   ```
2. Upgrade the cluster to a specific version:
   ```bash
   az aks upgrade \
     --resource-group myResourceGroup \
     --name myAKSCluster \
     --kubernetes-version <new-version>
   ```
   - Replace `<new-version>` with a version from the `get-upgrades` output (e.g., `1.28.3`).
3. Upgrade a specific node pool (if needed):
   ```bash
   az aks nodepool upgrade \
     --resource-group myResourceGroup \
     --cluster-name myAKSCluster \
     --name nodepool1 \
     --kubernetes-version <new-version>
   ```
4. Verify the upgrade:
   ```bash
   kubectl get nodes
   ```

---

### 5. Delete AKS Cluster (Optional)
1. Delete the AKS cluster to clean up resources:
   ```bash
   az aks delete \
     --name myAKSCluster \
     --resource-group myResourceGroup \
     --yes --no-wait
   ```

---

## Benefits of Using AKS
- Simplifies Kubernetes cluster management with managed control plane.
- Integrated monitoring via Azure Monitor.
- Built-in support for scaling and upgrading.
- Seamless integration with Azure AD and RBAC for secure access.

---

## Outcome
- Created an AKS cluster using the Azure Portal or CLI.
- Connected to the cluster using `kubectl` and verified nodes.
- Scaled the cluster manually and optionally enabled autoscaling.
- Upgraded the cluster to a newer Kubernetes version.
- Understood AKS management capabilities and benefits.

---

## Resources
- [YouTube: AKS Cluster Management](https://www.youtube.com/results?search_query=aks+cluster+management)
- [AKS Official Docs](https://learn.microsoft.com/azure/aks/)
- [Kubernetes Official Docs](https://kubernetes.io/docs/)
