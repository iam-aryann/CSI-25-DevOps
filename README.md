# Week 2 – Azure Infrastructure and Compute

This week focuses on exploring core compute services and infrastructure building blocks in Microsoft Azure. All tasks are performed using the **Azure Portal**, unless explicitly stated otherwise.

---

## Tasks Completed

### Task 1: Deploy Linux and Windows Virtual Machines
- Created and configured Linux and Windows VMs.
- Accessed:
  - Linux via SSH.
  - Windows via RDP.
- Verified connectivity and basic VM management.

---

### Task 2: App Service Plan and Web App
- Created an App Service Plan.
- Deployed a Web App into the plan.
- Uploaded a simple welcome HTML page and tested it using the public URL.

---

### Task 3: Azure Virtual Machine Scale Set (VMSS)
- Deployed a Virtual Machine Scale Set with a custom script extension.
- Applied auto-scaling based on CPU metrics.
- Verified instance creation on scale-out condition.

---

### Task 4: Azure Container Instance & Container Groups
- Deployed a Docker-based app using Azure Container Instances (ACI).
- Created container groups.
- Verified deployment via exposed ports and tested endpoints.

---

### Task 5: Virtual Network (VNet) Architecture and Hub-Spoke Model

#### A. Subnet Setup:
- Created a VNet with two subnets:
  - Subnet-1: Linux VM and Windows VM.
  - Subnet-2: Azure SQL DB.

#### B. Hub and Spoke Model:
- Created 4 VNets:
  - Management (Hub)
  - Production
  - Testing
  - Development
- Peered all Spoke VNets with the Hub.
- Deployed VMs in each VNet and verified communication by pinging from Management VM.

---

### Task 6: Internal and External Load Balancers
- Created:
  - External Load Balancer: To distribute traffic over web VMs.
  - Internal Load Balancer: For private VM traffic distribution.
- Verified backend pool status and rule functionality.

---

### Task 7: Azure Bastion
- Deployed Azure Bastion in a subnet named `AzureBastionSubnet`.
- Connected securely to Linux and Windows VMs via browser without using SSH/RDP clients.

---

### Task 8: DNS and Private Domain Setup
- Created a DNS Zone and custom domain.
- Deployed a DNS server on a VM and configured VM networking to route traffic via the DNS server.
- Validated name resolution using `nslookup`.

---

### Task 9: Azure Storage Account – Deep Dive
- Created a Storage Account with all options explored.
- Uploaded blobs and accessed them using:
  - Azure Portal
  - Azure Storage Explorer
- Explored Authentication Techniques:
  - Access Keys
  - Shared Access Signature (SAS)
  - Stored Access Policies
- Tested:
  - Access Tier configuration (Hot, Cool, Archive)
  - Lifecycle policies for auto-tiering
  - Object replication
- Created and mounted a File Share.
- Configured Azure File Sync with a Windows VM.

---

### Task 10: Azure Managed Disks
- Created and attached Managed Disks to VMs.
- Performed disk initialization and formatting (Linux/Windows).
- Created snapshots for backup.
- Changed performance tiers.
- Created and used shared managed disks for clustered VMs.
- Created a managed disk from uploaded `.vhd` file in a blob container.

---
