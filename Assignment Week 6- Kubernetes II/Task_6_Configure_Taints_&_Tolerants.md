## Task 6: Configure Taints and Tolerations in AKS

**Objective**:  
Configure taints on Kubernetes nodes and tolerations on pods to control workload scheduling, ensuring only specific workloads are placed on tainted nodes for isolation and cluster maintenance.

---

## Prerequisites
- An AKS cluster deployed (e.g., from Week 6, Task 4 or Week 5, Task 3).
- `kubectl` configured with cluster credentials:
  ```bash
  az aks get-credentials --resource-group <your-resource-group> --name <aks-cluster-name>
  ```
- Basic familiarity with Kubernetes YAML manifests.

---

## What Are Taints and Tolerations?
- **Taints**: Applied to nodes to prevent pods from being scheduled unless the pod has a matching toleration.
- **Tolerations**: Applied to pods to allow them to be scheduled on nodes with specific taints.
- **Use Cases**: Isolate nodes for specific workloads (e.g., GPU tasks) or prevent scheduling during maintenance.

---

## Steps to Complete the Task

### Step 1: Identify a Node
1. List all nodes in the AKS cluster:
   ```bash
   kubectl get nodes
   ```
2. Choose a node (e.g., `aks-nodepool1-12345678-0`) from the output.

---

### Step 2: Apply a Taint to the Node
1. Add a taint to the selected node with the `NoSchedule` effect:
   ```bash
   kubectl taint nodes aks-nodepool1-12345678-0 key1=value1:NoSchedule
   ```
   - This prevents pods without a matching toleration from being scheduled on the node.

---

### Step 3: Create a Pod With Matching Toleration
1. Create a file named `toleration-pod.yaml`:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: tolerant-pod
   spec:
     containers:
     - name: nginx
       image: nginx
     tolerations:
     - key: "key1"
       operator: "Equal"
       value: "value1"
       effect: "NoSchedule"
   ```
2. Apply the pod:
   ```bash
   kubectl apply -f toleration-pod.yaml
   ```

---

### Step 4: Verify Pod Placement
1. Check which node the pod is running on:
   ```bash
   kubectl get pod tolerant-pod -o wide
   ```
   - The pod should be scheduled on the tainted node (e.g., `aks-nodepool1-12345678-0`).

---

### Step 5: Clean Up
1. Remove the taint from the node:
   ```bash
   kubectl taint nodes aks-nodepool1-12345678-0 key1=value1:NoSchedule-
   ```
   - The `-` at the end removes the taint.
2. Delete the pod:
   ```bash
   kubectl delete pod tolerant-pod
   ```

---

## Types of Taint Effects
| **Effect**          | **Description**                                                                 |
|---------------------|--------------------------------------------------------------------------------|
| **NoSchedule**      | Prevents new pods from scheduling unless they tolerate the taint.               |
| **PreferNoSchedule**| Tries to avoid scheduling pods without tolerations, but not strictly enforced.  |
| **NoExecute**       | Evicts existing pods that don’t tolerate the taint and prevents new scheduling. |

---

## Use Cases
- **Node Isolation**: Dedicate nodes for specific workloads (e.g., GPU-based tasks, security-sensitive applications).
- **Node Maintenance**: Prevent pods from scheduling on nodes during updates or maintenance.

---

## Outcome
- Applied a taint (`key1=value1:NoSchedule`) to an AKS node.
- Created a pod with a matching toleration to schedule on the tainted node.
- Verified pod placement using `kubectl get pod -o wide`.
- Cleaned up by removing the taint and pod.

---

## Resources
- [YouTube: Kubernetes Taints and Tolerations](https://www.youtube.com/results?search_query=kubernetes+taints+and+tolerations)
- [YouTube: Upgrading and Maintaining your Azure Kubernetes Service (AKS) Cluster
](https://www.youtube.com/watch?v=soLCemusoE8)
- [Microsoft Docs: AKS Node Scheduling with Taints](https://learn.microsoft.com/azure/aks/operator-best-practices-scheduler#taints-and-tolerations)
- [Kubernetes Taints and Tolerations Documentation](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)
