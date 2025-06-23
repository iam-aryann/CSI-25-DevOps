# Task 7: VM Backup Scheduling and Alert Configuration

**Objective**:  
- **Part A**: Schedule daily VM backups at 3:00 AM using a Recovery Services Vault and create an alert rule for VM CPU usage > 80% with email notifications.  
- **Part B**: Provision backups from Backup Center and configure backup retention policies to retain older backups.

---

## Prerequisites
- Access to the [Azure Portal](https://portal.azure.com)
- Sufficient permissions (Owner or Contributor role)
- An existing Virtual Machine (VM) in Azure

---

## Part A: Daily Backup + CPU Alert Setup

### 1. Create Recovery Services Vault
1. Go to [Azure Portal](https://portal.azure.com) → Search for **Recovery Services Vault** → Click **Create**.
2. Configure:
   - **Name**: `MyRecoveryVault`
   - **Region**: Same as your VM
   - **Resource Group**: Same as your VM
3. Click **Review + Create** → **Create**.

### 2. Register VM with Vault
1. Open the **Recovery Services Vault**.
2. Go to **Backup** → Select:
   - **Where is your workload running?**: Azure
   - **What do you want to back up?**: Virtual Machine
3. Click **Backup**.
4. Select the VM to back up.
5. Click **Enable Backup**.

### 3. Create a Backup Policy – 3:00 AM Daily
1. In the **Vault**, go to **Backup Policies** → Click **+ Add**.
2. Configure:
   - **Policy Type**: Azure Virtual Machine
   - **Frequency**: Daily
   - **Time**: 03:00 AM
   - **Retention Range**: e.g., 30 days
3. Assign the policy to the VM.
4. Click **Save** and apply.

### 4. Create an Alert Rule for CPU > 80%
1. Go to your **VM** → **Monitoring** → **Alerts** → Click **+ New Alert Rule**.
2. Configure:
   - **Scope**: Select your VM
   - **Condition**:
     - **Signal name**: Percentage CPU
     - **Operator**: Greater Than
     - **Threshold**: 80
   - **Action Group**:
     - Click **Create new**
     - **Notification Type**: Email
     - Enter your email address
     - Name the action group (e.g., `CPUAlertGroup`)
   - **Alert Rule Name**: e.g., `HighCPUAlert`
3. Click **Create**.

---

## Part B: Backup Center + Retention Settings

### 1. Open Backup Center
1. Go to [Azure Portal](https://portal.azure.com) → Search for **Backup Center**.
2. Click **+ Backup**.

### 2. Select Resources to Backup
1. Configure **Backup Goal**:
   - **Where is workload**: Azure
   - **Type**: Virtual Machine
2. Select the **Recovery Services Vault** (`MyRecoveryVault`).
3. Choose the VM to back up.
4. Click **Next**.

### 3. Configure Retention Policy
1. Create or select a backup policy.
2. Configure:
   - **Schedule**: Daily at 3:00 AM
   - **Retention**:
     - **Daily**: e.g., 30 Days
     - **Weekly**: e.g., Every Sunday for 8 weeks
     - **Monthly/Yearly**: Optional
3. Apply the policy and complete the setup.

### 4. Retain an Old Backup (Optional)
1. Go to **Vault** → **Backup Items**.
2. Select the VM.
3. Use **Restore Point Collections** to manage or retain specific restore points manually.
4. To retain older backups, edit the retention rules in the backup policy:
   - Go to **Backup Policies** → Select policy → Update retention settings.

---

## Expected Outcome
- A daily backup runs automatically at 3:00 AM for the VM.
- CPU usage above 80% triggers an email alert.
- Backup Center reflects VM backups with configured retention policies.

---

## Resources
- [Azure Monitor Logs Log Types
](https://www.youtube.com/watch?v=lzVQ3NqMnTE)
- [Microsoft Docs – Backup Center](https://learn.microsoft.com/azure/backup/backup-center-overview)
- [Microsoft Docs – Alert Rules](https://learn.microsoft.com/azure/azure-monitor/alerts/alerts-overview)
