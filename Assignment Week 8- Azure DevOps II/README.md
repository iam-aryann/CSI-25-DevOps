# Week 8: Azure DevOps II

## Overview
This week focuses on advanced Azure DevOps features, including dashboards, pipeline variables, task groups, service connections, self-hosted agents, deployment approvals, and CI/CD pipelines targeting Azure Kubernetes Service (AKS), Azure Container Instances (ACI), Azure App Service, and Azure Virtual Machines (VMs). These tasks enhance automation, security, and scalability in team-based DevOps workflows.

---

## Tasks Overview

| **Task** | **Topic** | **Description** |
|----------|-----------|-----------------|
| **1** | Configure Dashboard and Queries for Work Items | Created dashboards to visualize project metrics and queries to filter tasks by assignee, status, and sprint. |
| **2** | Use Pipeline Variables | Declared pipeline- and stage-level variables in YAML pipelines for dynamic configuration and reusability. |
| **3** | Use Variable Groups and Task Groups | Centralized variables with Variable Groups, created reusable Task Groups, and scoped variables to specific stages. |
| **4** | Create a Service Connection | Established SSH and Azure Resource Manager (ARM) service connections for secure access to Linux VMs, ACR, and AKS. |
| **5** | Create a Linux/Windows Self-Hosted Agent | Configured a self-hosted agent on a Linux/Windows machine, integrated with Azure DevOps agent pool. |
| **6** | Apply Pre and Post-Deployment Approvers | Added manual approval gates for pre- and post-deployment in release pipelines to enforce quality and compliance. |
| **7** | CI/CD Pipeline to ACR and AKS | Built a Docker image, pushed it to ACR, and deployed it to AKS using Kubernetes manifests. |
| **8** | CI/CD Pipeline to ACR and ACI | Built and pushed a Docker image to ACR, then deployed it to ACI for lightweight container hosting. |
| **9** | CI/CD Pipeline for .NET App to App Service | Built a .NET application and deployed it to Azure App Service with automated CI/CD. |
| **10** | CI/CD Pipeline for React App to VM | Built a React.js app and deployed it to an Azure VM via SSH, served using Nginx. |

---

## Deliverables
- **`azure-pipelines.yml` files**: YAML configurations for pipelines in Tasks 7, 8, 9, and 10.
- **Configured Azure Dashboards and Queries**: Visuals and filters for work item tracking (Task 1).
- **Service Connections and Agents**: SSH and ARM connections (Task 4) and self-hosted agent setup (Task 5).
- **Screenshots and Logs**: Visual proof of successful pipeline runs, deployments, dashboards, and configurations.
- **Summary**:  
  This week enhanced skills in building scalable CI/CD pipelines, securing deployments with approvals and scoped variables, and managing diverse Azure targets (AKS, ACI, App Service, VMs) while centralizing configurations using Variable Groups and Task Groups.

---

## Resources
- [Microsoft Docs: Dashboard & Queries in Azure Boards](https://learn.microsoft.com/azure/devops/boards/dashboards/?view=azure-devops)
- [Microsoft Docs: Pipeline Variables](https://learn.microsoft.com/azure/devops/pipelines/process/variables?view=azure-devops)
- [Microsoft Docs: Variable Groups](https://learn.microsoft.com/azure/devops/pipelines/library/variable-groups?view=azure-devops)
- [Microsoft Docs: Task Groups](https://learn.microsoft.com/azure/devops/pipelines/library/task-groups?view=azure-devops)
- [Microsoft Docs: Service Connections](https://learn.microsoft.com/azure/devops/pipelines/library/service-endpoints?view=azure-devops)
- [Microsoft Docs: Linux Agent Setup](https://learn.microsoft.com/azure/devops/pipelines/agents/linux-agent?view=azure-devops)
- [Microsoft Docs: Approvals and Gates](https://learn.microsoft.com/azure/devops/pipelines/release/approvals/?view=azure-devops)
- [Microsoft Docs: Azure Pipelines Overview](https://learn.microsoft.com/azure/devops/pipelines/?view=azure-devops)
- [Microsoft Docs: CI/CD with Azure App Services](https://learn.microsoft.com/azure/app-service/deploy-github-actions)
- [YouTube: Azure DevOps Tutorials](https://www.youtube.com/results?search_query=azure+devops+tutorial)
