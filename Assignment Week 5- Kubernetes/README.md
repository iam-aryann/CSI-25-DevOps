# Week 5: Kubernetes

## Overview
This week focuses on mastering container orchestration using Kubernetes. You will create Kubernetes clusters using various methods, deploy applications, expose services, and manage multi-user environments in Azure Kubernetes Service (AKS).

---

## Tasks

### Task 1: Create a Kubernetes Cluster using Minikube
- Set up Minikube on a local machine.
- Start a single-node Kubernetes cluster.
- Verify the installation using:
  ```bash
  kubectl cluster-info
  kubectl get nodes
  ```
- 🔗 [Minikube Tutorial – YouTube](https://www.youtube.com/results?search_query=minikube+tutorial)

### Task 2: Create a Kubernetes Cluster using kubeadm
- Use VMs or physical machines (e.g., 1 master node, 1+ worker nodes).
- Initialize the control plane with:
  ```bash
  kubeadm init
  ```
- Join worker nodes using the `kubeadm join` command.
- Verify nodes with:
  ```bash
  kubectl get nodes
  ```
- 🔗 [Kubeadm Tutorial – YouTube](https://www.youtube.com/results?search_query=kubeadm+tutorial)

### Task 3: Deploy AKS Cluster via Azure Portal
- Provision an AKS cluster through the Azure Portal.
- Access the Kubernetes dashboard using:
  ```bash
  az aks browse --resource-group <resource-group> --name <aks-cluster>
  ```
- Create and assign RBAC roles for Azure AD users.
- 🔗 [AKS Cluster Deployment – YouTube](https://www.youtube.com/results?search_query=aks+cluster+deployment)

### Task 4: Deploy Microservice Application on AKS
- Deploy a sample microservice app using Kubernetes manifests or Helm.
- Expose the app with a `LoadBalancer` service for public access.
- Test accessibility via the public IP.
- 🔗 [Microservices on AKS – YouTube](https://www.youtube.com/results?search_query=microservices+on+aks)

### Task 5: Expose Services (ClusterIP, NodePort, LoadBalancer)
- Expose a deployed application using:
  - **ClusterIP**: For internal cluster communication.
  - **NodePort**: For external access via node IP and port.
  - **LoadBalancer**: For public access via a cloud provider’s load balancer.
- Verify access for each service type and observe network behavior.
- Commands used:
  ```bash
  kubectl expose deployment <name> --type=ClusterIP ...
  kubectl expose deployment <name> --type=NodePort ...
  kubectl expose deployment <name> --type=LoadBalancer ...
  ```
- 🔗 [Kubernetes Services Tutorial – YouTube](https://www.youtube.com/results?search_query=kubernetes+services+tutorial)

---

## Key Learnings
- Basics of Kubernetes architecture and components (e.g., control plane, nodes, pods).
- Differences between Minikube (local), kubeadm (manual), and AKS (managed).
- Understanding Kubernetes service types (`ClusterIP`, `NodePort`, `LoadBalancer`) and their use cases.
- Writing and applying Kubernetes manifests for deployments and services.
- Implementing Kubernetes Role-Based Access Control (RBAC) for secure access.

---

## Resources
- [Kubernetes Official Docs](https://kubernetes.io/docs/)
- [AKS Documentation](https://learn.microsoft.com/azure/aks/)
- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)
- [Kubeadm Documentation](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)
- [YouTube: AKS Cluster Deployment](https://www.youtube.com/results?search_query=aks+cluster+deployment)
- [YouTube: Microservices on AKS](https://www.youtube.com/results?search_query=microservices+on+aks)
- [YouTube: Minikube Tutorial](https://www.youtube.com/results?search_query=minikube+tutorial)
