# Task 8: Backup Scheduling and Alert Management

**Objective**:  
- **Part A**: Schedule a daily VM backup at 3:00 AM using a Recovery Services Vault and create an alert rule for CPU usage > 80% with email notifications.  
- **Part B**: Provision backups using Backup Center and configure a backup retention policy to retain older backups.

---

## Prerequisites
- Access to the [Azure Portal](https://portal.azure.com)
- Sufficient permissions (Owner or Contributor role)
- An existing Virtual Machine (VM) in Azure

---

## Part A: Schedule Backup at 3:00 AM & Configure CPU Alert

### 1. Create a Recovery Services Vault
1. Go to [Azure Portal](https://portal.azure.com) → Search for **Recovery Services Vault** → Click **+ Create**.
2. Configure:
   - **Name**: `MyBackupVault`
   - **Resource Group**: Same as your VM
   - **Region**: Same as your VM
3. Click **Review + Create** → **Create**.

### 2. Configure VM Backup Schedule
1. Open the **Recovery Services Vault**.
2. Go to **Backup** → Select:
   - **Where is your workload running?**: Azure
   - **What do you want to back up?**: Virtual Machine
3. Click **Backup**.
4. Select your VM.
5. Click **Enable Backup**.

### 3. Modify Backup Policy (Set 3:00 AM Schedule)
1. In the **Vault**, go to **Backup Policies** → Click **+ Add** or select an existing policy to modify.
2. Configure:
   - **Policy Type**: Azure Virtual Machine
   - **Frequency**: Daily
   - **Time**: 03:00 AM
   - **Retention**: e.g., 30 days
3. Save and assign the policy to the VM.

### 4. Set Alert Rule for CPU > 80% with Email Notification
1. Go to your **VM** → **Monitoring** → **Alerts** → Click **+ Create**.
2. Configure:
   - **Scope**: Current VM
   - **Condition**:
     - **Signal**: Percentage CPU
     - **Condition**: Greater than
     - **Threshold**: 80
   - **Action Group**:
     - Click **+ New**
     - Name the group (e.g., `CPUAlertGroup`)
     - Select **Email** notification → Enter your email
     - Save the action group
   - **Alert Rule Name**: e.g., `HighCPUAlert`
3. Click **Create**.

---

## Part B: Provision Backups in Backup Center & Set Retention Policy

### 1. Go to Backup Center
1. In [Azure Portal](https://portal.azure.com), search for **Backup Center**.
2. Click **+ Backup**.

### 2. Configure Backup from Backup Center
1. Configure:
   - **Where is your workload running?**: Azure
   - **What do you want to back up?**: Virtual Machine
2. Select the **Recovery Services Vault** (`MyBackupVault`).
3. Select the VM.
4. Click **Next** → Proceed to **Backup Policy**.

### 3. Create or Use a Backup Policy with Retention
1. Click **+ Create new policy**.
2. Configure:
   - **Schedule**: Daily at 3:00 AM
   - **Retention**:
     - **Daily**: 30 Days
     - **Weekly**: Optional (e.g., every Sunday for 8 weeks)
     - **Monthly/Yearly**: Optional for long-term storage
3. Click **OK**, assign the policy, and enable backup.

### 4. Retain Older Backups
1. Go to **Vault** → **Backup Items**.
2. Click your VM.
3. Use **Restore Points** to manually retain specific backups or configure longer retention.
4. To extend retention, modify the backup policy:
   - Go to **Backup Policies** → Select policy → Update retention settings.

---

## Expected Outcome
- Daily VM backup scheduled at 3:00 AM via Recovery Services Vault, visible in Backup Center.
- CPU utilization above 80% triggers an email alert.
- Backup retention policy applied, with older backups retained as configured.

---

## Resources
- [Azure Application Insights Tutorial | Amazing telemetry service
](https://www.youtube.com/watch?v=A0jAeGf2zUQ)
- [Microsoft Docs – Backup Center](https://learn.microsoft.com/azure/backup/backup-center-overview)
- [Azure Alerts Documentation](https://learn.microsoft.com/azure/azure-monitor/alerts/alerts-overview)
