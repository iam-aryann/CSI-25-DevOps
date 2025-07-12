## Task 3: PersistentVolume (PV) and PersistentVolumeClaim (PVC)

**Objective**:  
Understand and implement persistent storage in Kubernetes using `PersistentVolume` (PV) and `PersistentVolumeClaim` (PVC), and bind them to a pod for data persistence.

---

## Prerequisites
- A running Kubernetes cluster (e.g., Minikube, AKS, or kubeadm from previous tasks).
- `kubectl` configured to interact with the cluster (e.g., `kubectl cluster-info`).
- For Minikube, ensure the `hostPath` storage type is supported. For AKS, consider using Azure Disk or Azure Files for production-grade storage.

---

## Concepts

### 1. What is a PersistentVolume (PV)?
A `PersistentVolume` is a piece of storage in the cluster, provisioned manually by an administrator or dynamically using Storage Classes. It is independent of the pod lifecycle, ensuring data persistence.

### 2. What is a PersistentVolumeClaim (PVC)?
A `PersistentVolumeClaim` is a user’s request for storage, specifying size, access modes (e.g., `ReadWriteOnce`), and optionally a storage class. Kubernetes binds a PVC to an appropriate PV.

---

## Steps to Complete the Task

### 3. Create a PersistentVolume (PV)
1. Create a file named `pv.yaml`:
   ```yaml
   apiVersion: v1
   kind: PersistentVolume
   metadata:
     name: my-pv
   spec:
     capacity:
       storage: 1Gi
     accessModes:
       - ReadWriteOnce
     hostPath:
       path: "/mnt/data"
   ```
   - `hostPath`: Uses a directory on the node’s filesystem (suitable for Minikube or testing; use cloud-specific storage like Azure Disk for AKS in production).
2. Apply the PV:
   ```bash
   kubectl apply -f pv.yaml
   ```

---

### 4. Create a PersistentVolumeClaim (PVC)
1. Create a file named `pvc.yaml`:
   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: my-pvc
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 1Gi
   ```
2. Apply the PVC:
   ```bash
   kubectl apply -f pvc.yaml
   ```

---

### 5. Mount PVC into a Pod
1. Create a file named `pod-with-pvc.yaml`:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: mypod
   spec:
     containers:
       - name: mycontainer
         image: nginx
         volumeMounts:
           - mountPath: "/usr/share/nginx/html"
             name: my-volume
     volumes:
       - name: my-volume
         persistentVolumeClaim:
           claimName: my-pvc
   ```
   - The PVC is mounted to `/usr/share/nginx/html`, where NGINX serves web content.
2. Apply the pod:
   ```bash
   kubectl apply -f pod-with-pvc.yaml
   ```

---

### 6. Verify the Setup
1. Check the status of the PV, PVC, and pod:
   ```bash
   kubectl get pv
   kubectl get pvc
   kubectl get pod mypod
   ```
   - The pod should be in the `Running` state.
   - The PVC should show as `Bound` to the PV.
2. To verify data persistence:
   - Access the pod:
     ```bash
     kubectl exec -it mypod -- bash
     ```
   - Write a test file to the mounted volume:
     ```bash
     echo "Test data" > /usr/share/nginx/html/test.txt
     ```
   - Delete and recreate the pod, then verify the file persists:
     ```bash
     kubectl delete pod mypod
     kubectl apply -f pod-with-pvc.yaml
     kubectl exec -it mypod -- cat /usr/share/nginx/html/test.txt
     ```

---

## Use Cases
- **Data Persistence**: Retain data across pod restarts or crashes (e.g., for databases like MySQL or MongoDB).
- **Log Storage**: Store logs or configuration files that need to persist beyond a pod’s lifecycle.
- **Shared Storage**: Provide consistent storage for stateful applications.

---

## Outcome
- Created a `PersistentVolume` (PV) and `PersistentVolumeClaim` (PVC) in a Kubernetes cluster.
- Mounted the PVC to a pod, binding it to the `/usr/share/nginx/html` directory.
- Verified data persistence across pod restarts.
- Understood the roles of PV and PVC in managing Kubernetes storage.

---

## Resources
- [YouTube: Kubernetes Volumes explained | Persistent Volume, Persistent Volume Claim & Storage Class
](https://www.youtube.com/watch?v=0swOh5C3OVM)
- [YouTube: Kubernetes Persistent Volumes](https://www.youtube.com/results?search_query=kubernetes+persistent+volumes)
- [Kubernetes PV/PVC Official Docs](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
- [AKS Storage Documentation](https://learn.microsoft.com/azure/aks/concepts-storage)
