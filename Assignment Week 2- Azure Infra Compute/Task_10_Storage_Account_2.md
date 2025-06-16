# Task 10: Azure Managed Disks + Extended Storage Capabilities

**Objective**:  
Explore Azure Managed Disks, create and attach disks to VMs, configure snapshots, integrate with Azure Storage, and apply advanced features like encryption, performance tiers, and shared disks.

---

## Step 1: Understanding Azure Managed Disks
Azure Managed Disks are virtual hard disks (VHDs) used with Azure VMs, with Azure managing the underlying storage account.

### A. Types of Managed Disks
- **Standard HDD**: For dev/test workloads, low cost
- **Standard SSD**: Better latency, cost-effective
- **Premium SSD**: High-performance workloads
- **Ultra Disk**: Mission-critical workloads with high IOPS/throughput

### B. Create a Managed Disk
1. Go to [Azure Portal](https://portal.azure.com) → Search for **Disks** → Click **+ Add**.
2. Configure:
   - **Name**: `myManagedDisk`
   - **Region**: Match your VM region
   - **Availability Zone**: Optional
   - **Source Type**: Empty (or use snapshot/custom image)
   - **Size**: e.g., 128 GiB
   - **Performance Tier**: Choose based on disk type (e.g., Standard SSD)
3. Click **Review + Create** → **Create**.

### C. Attach Managed Disk to VM
1. Go to **Virtual Machines** → Select a VM → **Disks**.
2. Click **+ Add data disk** → Choose `myManagedDisk`.
3. Click **Save**.
4. Log in to the VM via SSH (Linux) or RDP (Windows):
   - **Linux**: Initialize, format, and mount the disk:
     ```bash
     sudo fdisk /dev/sdX  # Replace X with disk identifier
     sudo mkfs.ext4 /dev/sdX1
     sudo mkdir /mnt/datadisk
     sudo mount /dev/sdX1 /mnt/datadisk
     ```
   - **Windows**: Use Disk Management to initialize, format, and assign a drive letter.

### D. Snapshots and Backup
1. Go to **Disks** → Select `myManagedDisk` → Click **Create Snapshot**.
2. Use snapshots for:
   - Backups
   - Creating new managed disks (restore, clone, etc.)
3. To restore, create a new disk from the snapshot via **Disks** → **+ Create**.

---

## Step 2: Integration with Azure Storage (Recap + Advanced)

### A. Upload VHD to Blob and Create Disk from It
1. Create a **Storage Account** → Create a **Container**.
2. Upload a `.vhd` file to the container.
3. Go to **Disks** → Click **+ Create**.
4. Configure:
   - **Source Type**: Storage Blob
   - **Blob URI**: Provide the URI of the uploaded VHD
5. Use case: Custom OS images, migrations, or restoring old disks.

### B. Disk Encryption (Security)
Managed disks support encryption with:
- **Platform-managed keys**: Enabled by default
- **Customer-managed keys**: Stored in Azure Key Vault
1. Go to **Disk** → **Encryption** tab.
2. Configure customer-managed keys if needed (requires Key Vault setup).

### C. Performance Tiers and Resizing
1. Change performance tier post-creation:
   - Via Azure CLI:
     ```bash
     az disk update --name myManagedDisk --resource-group myRG --sku Premium_LRS
     ```
   - Via Portal: Go to **Disk** → **Configuration** → **Size + Performance**.
2. Resize disk via the same **Configuration** tab by selecting a larger size.

### D. Shared Disks (For Clustering)
1. Create a managed disk with **Enable shared disk** option.
2. Attach the disk to multiple VMs.
3. Use case: Clustering scenarios (e.g., SQL Server Failover Cluster Instance).

---

## Reference Videos & Docs
- [Azure Managed Disks Deep Dive
](https://www.youtube.com/watch?v=2nPZyLmciN4)
- [YouTube - Azure Managed Disks Explained](https://www.youtube.com/results?search_query=azure+managed+disks)
- [Microsoft Docs – Azure Storage Overview](https://docs.microsoft.com/azure/storage/common/storage-introduction)
- [Azure Managed Disks Documentation](https://docs.microsoft.com/azure/virtual-machines/managed-disks-overview)
