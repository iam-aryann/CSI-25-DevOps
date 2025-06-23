# Week 3: Azure Infrastructure – Identity, Management, and Governance

This week focuses on managing Azure subscriptions, users, roles, access policies, identity services, and governance mechanisms using the Azure Portal, CLI, and PowerShell.

---

## Tasks Overview

### Task 1: Azure Entra ID and RBAC
- Observed existing Azure subscriptions and Entra ID.
- Created custom users and groups.
- Assigned built-in RBAC roles (e.g., Reader, Contributor).
- Created a custom RBAC role with scoped permissions and tested it.

### Task 2: Azure Active Directory and Resource Access
- Created and managed users and groups via Azure Entra ID.
- Assigned role-based access at different levels (Subscription, Resource Group).
- Verified permission boundaries for each role.

### 🔹 Task 3: Create VM and VNet via Azure CLI
- Used Azure CLI to:
  - Create a Virtual Network (VNet).
  - Deploy a Virtual Machine (Linux/Windows).
  - Validate network connectivity and SSH/RDP access.

### Task 4: Azure Policy Assignment
- Created a Policy Definition (e.g., restrict VM size or region).
- Assigned the policy at the subscription level.
- Evaluated compliance reports to check which resources violated the policy.

### Task 5: Azure Key Vault
- Created an Azure Key Vault.
- Stored secrets (e.g., API keys, DB passwords).
- Configured Access Policies to control who can manage/read secrets.
- Retrieved secrets via Azure CLI.

### Task 6: Deploy VM via PowerShell
- Installed Azure PowerShell.
- Used cmdlets to:
  - Authenticate and set subscription.
  - Create a resource group and VM.
  - Assign NSG rules for RDP/SSH.

### Task 7–9: Backup & Monitoring Configuration
- Scheduled daily backup for VM at 3:00 AM via Recovery Services Vault.
- Created alert rules for VM CPU > 80% with email notifications.
- Provisioned and managed backups through Backup Center.
- Configured retention policies to preserve old recovery points.

---

## Tools & Technologies Used
- Azure Portal
- Azure CLI
- Azure PowerShell
- Azure Entra ID
- Azure Key Vault
- Recovery Services Vault
- Backup Center
- Azure Monitor (for Alerts)
- Azure Policy

---

## Resources & References
- [Azure CLI Documentation](https://learn.microsoft.com/azure/cli/)
- [Azure PowerShell Guide](https://learn.microsoft.com/powershell/azure/)
- [Azure Key Vault](https://learn.microsoft.com/azure/key-vault/)
- [Azure Policy Overview](https://learn.microsoft.com/azure/governance/policy/overview)
- [Backup Center Documentation](https://learn.microsoft.com/azure/backup/backup-center-overview)
