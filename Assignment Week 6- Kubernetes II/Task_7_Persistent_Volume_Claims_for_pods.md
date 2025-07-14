## Task 7: Create and Attach Persistent Volume Claims (PVCs) to Pods in AKS

**Objective**:  
Learn to create a PersistentVolumeClaim (PVC) and attach it to a pod in Azure Kubernetes Service (AKS) to enable persistent data storage beyond the pod lifecycle.

---

## Prerequisites
- An AKS cluster deployed (e.g., from Week 6, Task 4 or Week 5, Task 3).
- `kubectl` configured with cluster credentials:
  ```bash
  az aks get-credentials --resource-group <your-resource-group> --name <aks-cluster-name>
  ```
- Azure CLI installed (verify with `az --version`).
- Basic familiarity with Kubernetes YAML manifests.

---

## Steps to Complete the Task

### Step 1: Create a Storage Class (Optional)
1. Check existing StorageClasses in AKS:
   ```bash
   kubectl get storageclass
   ```
   - AKS provides default StorageClasses like `default` (Azure Disk) or `managed-premium`. You can use these unless specific requirements exist.
2. (Optional) Create a custom StorageClass (`azure-storageclass.yaml`):
   ```yaml
   apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: azure-managed
   provisioner: kubernetes.io/azure-disk
   parameters:
     storageaccounttype: Standard_LRS
     kind: Managed
   reclaimPolicy: Retain
   volumeBindingMode: Immediate
   ```
3. Apply the StorageClass:
   ```bash
   kubectl apply -f azure-storageclass.yaml
   ```

---

### Step 2: Create a PersistentVolumeClaim
1. Create a file named `pvc.yaml`:
   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: azure-pvc
   spec:
     accessModes:
       - ReadWriteOnce
     storageClassName: azure-managed
     resources:
       requests:
         storage: 1Gi
   ```
   - `storageClassName: azure-managed` links to the custom StorageClass (or use `default`/`managed-premium` if not creating a custom one).
2. Apply the PVC:
   ```bash
   kubectl apply -f pvc.yaml
   ```

---

### Step 3: Create a Pod That Uses the PVC
1. Create a file named `pod-using-pvc.yaml`:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: app-with-pvc
   spec:
     containers:
     - name: app
       image: nginx
       volumeMounts:
       - mountPath: "/usr/share/nginx/html"
         name: azure-storage
     volumes:
     - name: azure-storage
       persistentVolumeClaim:
         claimName: azure-pvc
   ```
   - The PVC is mounted at `/usr/share/nginx/html`, where NGINX serves web content.
2. Apply the pod:
   ```bash
   kubectl apply -f pod-using-pvc.yaml
   ```

---

### Step 4: Verify
1. Confirm the PVC is bound:
   ```bash
   kubectl get pvc
   ```
   - The `STATUS` should be `Bound`.
2. Check the pod status:
   ```bash
   kubectl get pods
   kubectl describe pod app-with-pvc
   ```
3. (Optional) Verify data persistence:
   - Exec into the pod:
     ```bash
     kubectl exec -it app-with-pvc -- /bin/bash
     ```
   - Write a test file:
     ```bash
     echo "Hello from PVC!" > /usr/share/nginx/html/index.html
     ```
   - Exit and delete the pod:
     ```bash
     exit
     kubectl delete pod app-with-pvc
     ```
   - Recreate the pod and verify the file persists:
     ```bash
     kubectl apply -f pod-using-pvc.yaml
     kubectl exec -it app-with-pvc -- cat /usr/share/nginx/html/index.html
     ```
     - Expected output: `Hello from PVC!`

---

### Step 5: Clean Up
1. Delete the pod, PVC, and StorageClass:
   ```bash
   kubectl delete pod app-with-pvc
   kubectl delete pvc azure-pvc
   kubectl delete storageclass azure-managed
   ```

---

## Use Cases
- **Persistent Storage**: Store logs, user uploads, or database data that persists beyond pod restarts.
- **Decoupled Storage**: Separate storage lifecycle from pod lifecycle for stateful applications.

---

## Outcome
- Created a StorageClass (optional) and a PersistentVolumeClaim (PVC) in AKS.
- Attached the PVC to a pod, mounting it at `/usr/share/nginx/html`.
- Verified data persistence across pod restarts.

---

## Resources
- [YouTube: Kubernetes Persistent Volumes in AKS](https://www.youtube.com/results?search_query=kubernetes+persistent+volumes+aks)
- [Azure Kubernetes Service (AKS) Security Explained
](https://www.youtube.com/watch?v=JD3mj5bTOuk)
- [Microsoft Docs: Storage in Azure Kubernetes Service (AKS)](https://learn.microsoft.com/azure/aks/concepts-storage)
- [Kubernetes PV/PVC Documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
