# Task 9: Backup Scheduling and CPU Alert Configuration

**Objective**:  
Reinforce Task 8 by configuring a daily VM backup at 3:00 AM using a Recovery Services Vault, setting up CPU usage alerts (> 80%) with email notifications, provisioning backups via Backup Center, and defining a retention policy to preserve older backups.

---

## Prerequisites
- Access to the [Azure Portal](https://portal.azure.com)
- Sufficient permissions (Owner or Contributor role)
- An existing Virtual Machine (VM) in Azure

---

## Part A: Backup Scheduling & CPU Alert (Vault-based)

### 1. Create/Use Recovery Services Vault
1. Go to [Azure Portal](https://portal.azure.com) → Search for **Recovery Services Vault** → Click **+ Create**.
2. Configure:
   - **Name**: `MyBackupVault`
   - **Resource Group**: Same as your VM
   - **Region**: Same as your VM
3. Click **Review + Create** → **Create**.

### 2. Enable Backup for VM
1. Open the **Recovery Services Vault** → Go to **Backup**.
2. Configure:
   - **Workload**: Azure
   - **Type**: Virtual Machine
3. Select your VM → Click **Enable Backup**.

### 3. Modify Backup Policy
1. In the **Vault**, go to **Backup Policies** → Create or edit an existing policy.
2. Configure:
   - **Frequency**: Daily
   - **Time**: 03:00 AM
   - **Retention**: 30+ days
3. Save and assign the policy to the VM.

### 4. Create CPU Alert (Email Notification)
1. Go to your **VM** → **Alerts** → Click **+ Create**.
2. Configure:
   - **Scope**: Current VM
   - **Condition**:
     - **Metric**: Percentage CPU
     - **Operator**: Greater Than
     - **Threshold**: 80
   - **Action Group**:
     - Click **+ New**
     - Set email recipient
     - Name the action group (e.g., `CPUAlertGroup`)
   - Name the alert rule (e.g., `HighCPUAlert`)
3. Click **Create**.

---

## Part B: Backup Center Provisioning & Retention Settings

### 1. Go to Backup Center
1. In [Azure Portal](https://portal.azure.com), search for **Backup Center**.
2. Click **+ Backup**.

### 2. Configure Backup via Backup Center
1. Configure:
   - **Workload**: Azure VM
   - **Vault**: Use existing `MyBackupVault`
2. Select your VM.
3. Assign a backup policy → Click **Next**.

### 3. Create/Use Backup Policy with Retention
1. Create or select a policy:
   - **Schedule**: Daily at 3:00 AM
   - **Retention**:
     - **Daily**: 30 Days
     - **Monthly/Yearly**: Optional for long-term storage
2. Apply the policy and enable backup.

### 4. Retain Older Backups
1. Go to **Vault** → **Backup Items**.
2. Select your VM → Review **Restore Points**.
3. To retain older backups, modify the backup policy:
   - Go to **Backup Policies** → Select policy → Update retention settings.

---

## Expected Outcome
- VM backups run daily at 3:00 AM via Recovery Services Vault and are visible in Backup Center.
- CPU usage > 80% triggers email alerts.
- Backup retention policy is applied, preserving older backups as configured.

---

## Resources
- [YouTube: Azure Backup Task Walkthrough](https://www.youtube.com/results?search_query=azure+backup+tutorial)
- [AZ CLI Overview and Demo Super Show
](https://www.youtube.com/watch?v=DOywwse_j8I)
- [Azure Docs – Backup Center](https://learn.microsoft.com/azure/backup/backup-center-overview)
- [Azure Alerts Overview](https://learn.microsoft.com/azure/azure-monitor/alerts/alerts-overview)
