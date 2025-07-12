# Week 6: Kubernetes II
## Task 1: Deploy ReplicaSet, ReplicationController, and Deployment in Kubernetes

**Objective**:  
Understand and implement key Kubernetes workload controllers: `ReplicationController`, `ReplicaSet`, and `Deployment`. Learn their use cases, advantages, and limitations.

---

## Prerequisites
- A running Kubernetes cluster (e.g., Minikube, AKS, or kubeadm from Week 5 tasks).
- `kubectl` configured to interact with the cluster (e.g., `kubectl cluster-info`).
- Basic familiarity with Kubernetes YAML manifests.

---

## Steps to Complete the Task

### Step 1: Deploy a ReplicationController
1. Create a file named `rc.yaml`:
   ```yaml
   apiVersion: v1
   kind: ReplicationController
   metadata:
     name: my-rc
   spec:
     replicas: 2
     selector:
       app: rc-app
     template:
       metadata:
         labels:
           app: rc-app
       spec:
         containers:
         - name: rc-container
           image: nginx
           ports:
           - containerPort: 80
   ```
2. Deploy the `ReplicationController`:
   ```bash
   kubectl apply -f rc.yaml
   ```
3. Verify the deployment:
   ```bash
   kubectl get rc
   kubectl get pods
   ```
   - You should see the `my-rc` ReplicationController and 2 pods running with the `rc-app` label.

---

### Step 2: Deploy a ReplicaSet
1. Create a file named `replicaset.yaml`:
   ```yaml
   apiVersion: apps/v1
   kind: ReplicaSet
   metadata:
     name: my-replicaset
   spec:
     replicas: 3
     selector:
       matchLabels:
         app: rs-app
     template:
       metadata:
         labels:
           app: rs-app
       spec:
         containers:
         - name: rs-container
           image: nginx
           ports:
           - containerPort: 80
   ```
2. Deploy the `ReplicaSet`:
   ```bash
   kubectl apply -f replicaset.yaml
   ```
3. Verify the deployment:
   ```bash
   kubectl get rs
   kubectl get pods
   ```
   - You should see the `my-replicaset` ReplicaSet and 3 pods running with the `rs-app` label.

---

### Step 3: Deploy a Deployment
1. Create a file named `deployment.yaml`:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: my-deployment
   spec:
     replicas: 3
     selector:
       matchLabels:
         app: deploy-app
     template:
       metadata:
         labels:
           app: deploy-app
       spec:
         containers:
         - name: deploy-container
           image: nginx
           ports:
           - containerPort: 80
   ```
2. Deploy the `Deployment`:
   ```bash
   kubectl apply -f deployment.yaml
   ```
3. Verify the deployment:
   ```bash
   kubectl get deployments
   kubectl get pods
   ```
   - You should see the `my-deployment` Deployment and 3 pods running with the `deploy-app` label.

---

## Advantages & Disadvantages

| Controller            | Advantages                                              | Disadvantages                                              |
|-----------------------|--------------------------------------------------------|------------------------------------------------------------|
| **ReplicationController** | Basic controller, maintains desired pod count          | Deprecated, lacks advanced features like rolling updates   |
| **ReplicaSet**        | Replaces ReplicationController, supports `matchLabels`  | Not used directly, typically managed by Deployments        |
| **Deployment**        | Supports rolling updates, rollbacks, and scaling        | Slightly more complex but the standard choice for workloads |

---

## Outcome
- Successfully deployed a `ReplicationController`, `ReplicaSet`, and `Deployment` in a Kubernetes cluster.
- Verified the creation of pods and their controllers using `kubectl`.
- Understood the differences, use cases, and limitations of each controller.

---

## Resources
- [YouTube: 25. Kubernetes ( In Hindi ) - ReplicaSet & Diff between Replicaset and Replication Controller
](https://www.youtube.com/watch?v=iAxBaTMoRwo)
- [YouTube: ReplicaSets and Deployments | Self Healing, High Availability, Rollout, and Rollback in Kubernetes
](https://www.youtube.com/watch?v=mEnCFazQ8BM) 
- [YouTube: ReplicaSet vs Deployment](https://www.youtube.com/results?search_query=kubernetes+replicaset+vs+deployment)
- [YouTube: Kubernetes Self-Healing Apps](https://www.youtube.com/results?search_query=kubernetes+self+healing+apps)
- [Kubernetes Official Docs](https://kubernetes.io/docs/concepts/workloads/controllers/)
