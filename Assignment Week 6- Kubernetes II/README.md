# Week 6: Kubernetes II - Advanced Concepts in Kubernetes & AKS

## Overview
This week dives into advanced Kubernetes concepts, focusing on workload controllers, service types, persistent storage, health probes, autoscaling, and Azure Kubernetes Service (AKS) management. You’ll use `kubectl`, Azure Portal, and YAML manifests to configure, deploy, and monitor Kubernetes applications effectively.

---

## Tasks Covered

| **Task No.** | **Topic** | **Description** |
|--------------|-----------|-----------------|
| 1 | ReplicaSet, Replication Controller, Deployment | Deploy applications using different controllers and understand their advantages and limitations. |
| 2 | Service Types (ClusterIP, NodePort, LoadBalancer) | Configure internal and external access for services using `ClusterIP`, `NodePort`, and `LoadBalancer`. |
| 3 | PersistentVolume & PersistentVolumeClaim (PV & PVC) | Implement persistent storage for stateless containers using PVs and PVCs. |
| 4 | Managing AKS Clusters | Create, scale, and upgrade AKS clusters using Azure Portal or CLI. |
| 5 | Liveness and Readiness Probes | Configure probes to monitor pod health and ensure availability. |
| 6 | Taints and Tolerations | Use taints and tolerations to control pod scheduling for workload isolation. |
| 7 | PVC Attached to Pods | Attach persistent storage to pods for data persistence in AKS. |
| 8 | Health Probes for Pods | Reinforce liveness and readiness probes with practical configuration. |
| 9 | Horizontal Pod Autoscaling (HPA) | Set up autoscaling based on CPU usage using Metrics Server and HPA. |

---

## Tools and Technologies
- Kubernetes (`kubectl`)
- Azure Kubernetes Service (AKS)
- Azure Portal
- YAML configuration files
- Minikube or kubeadm (for local/offline setup)
- Metrics Server

---

## Learning Outcomes
- Deep understanding of Kubernetes workload controllers (`ReplicationController`, `ReplicaSet`, `Deployment`).
- Mastery of service discovery and access methods (`ClusterIP`, `NodePort`, `LoadBalancer`).
- Familiarity with persistent storage using `PersistentVolume` and `PersistentVolumeClaim`.
- Proficiency in managing AKS clusters (creation, scaling, upgrading).
- Expertise in implementing auto-healing (probes) and autoscaling (HPA) for Kubernetes workloads.

---

## Resources
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Azure AKS Documentation](https://learn.microsoft.com/azure/aks/)
- [YouTube Tutorials: Kubernetes and AKS](https://www.youtube.com/results?search_query=kubernetes+aks+tutorial)
- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/)
- [Kubeadm Documentation](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)
