# Task 9: Azure Storage Account – Deep Dive

**Objective**:  
Create and configure an Azure Storage Account, explore blob storage, authentication methods, access tiers, lifecycle management, object replication, file shares, and Azure File Sync.

---

## Step 1: Create a Storage Account
1. Go to [Azure Portal](https://portal.azure.com) → Search for **Storage Accounts** → Click **Create**.
2. Configure:
   - **Resource Group**: Select or create one
   - **Storage Account Name**: Globally unique (e.g., `mystorage1234`)
   - **Region**: Choose a nearby Azure region
   - **Performance**: Standard
   - **Redundancy**: Locally Redundant Storage (LRS) or Geo-Redundant Storage (GRS) for replication testing
3. Explore other tabs (**Networking**, **Data Protection**, **Advanced**) for additional options.
4. Click **Review + Create** → **Create**.

---

## Step 2: Upload and Access a Blob
1. Go to **Storage Account** → **Containers** → Click **+ Container**.
2. Configure:
   - **Name**: `test-container`
   - **Public Access Level**: Private
3. Inside `test-container`, upload a test file (e.g., `hello.txt`).
4. Test access:
   - Click the blob → Copy its **URL**.
   - Paste the URL in a browser → Should return a "Forbidden" error (due to private access).

---

## Step 3: Authentication Technologies

### A. Access Keys
1. Go to **Storage Account** → **Access Keys**.
2. Copy **Key1** and **Connection String** for use in tools like Azure Storage Explorer.

### B. Azure Storage Explorer (GUI Tool)
1. Download and install [Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/).
2. Connect to the storage account using the **Connection String** from Access Keys.
3. Use Storage Explorer to upload, download, and delete blobs in `test-container`.

---

## Step 4: Shared Access Signature (SAS)
1. Go to **Storage Account** → **Shared access signature**.
2. Configure:
   - **Allowed services**: Blob
   - **Allowed resource types**: Object
   - **Permissions**: Read, Write
   - **Expiry**: Set a short duration (e.g., 1 hour)
3. Click **Generate SAS and Connection String**.
4. Copy the **Blob SAS Token** and append it to the blob URL:
   ```
   https://<account>.blob.core.windows.net/test-container/hello.txt?<sas_token>
   ```
5. Paste the URL in a browser → You should now access the blob.

---

## Step 5: Stored Access Policy
1. Go to `test-container` → **Access Policy** → Click **Add policy**.
2. Configure:
   - Set start and expiry dates
   - Permissions: e.g., Read
3. Generate a SAS token for a blob and associate it with the stored policy.
4. Test access → The scope and expiry are now managed centrally by the policy.

---

## Step 6: Access Tiers & Lifecycle Management

### A. Blob Access Tiers
1. Go to the `hello.txt` blob in `test-container` → Click **Change Tier**.
2. Select:
   - **Hot**: For frequently accessed data
   - **Cool**: For infrequent access
   - **Archive**: For long-term storage with slow retrieval
3. **Note**: Use Hot for active data, Cool for backups, and Archive for compliance.

### B. Lifecycle Policy
1. Go to **Storage Account** → **Lifecycle Management** → Click **Add rule**.
2. Configure an example rule:
   - If a blob hasn’t been modified in 30 days → Move to **Cool** tier
   - If a blob hasn’t been accessed in 90 days → **Delete**
3. Test by waiting or manually editing the blob’s last modified date (if needed).

---

## Step 7: Object Replication
1. Create a second storage account in a different region.
2. Go to the source **Storage Account** → **Data Management** → Enable **Object Replication**.
3. Configure:
   - **Source**: Current storage account
   - **Destination**: Second storage account
   - **Container**: Map source (`test-container`) to destination container
4. Upload a blob to the source container → Verify it is copied to the destination container.

---

## Step 8: Azure File Share
1. Go to **Storage Account** → **File Shares** → Click **+ File Share**.
2. Configure:
   - **Name**: `testfileshare`
   - **Quota**: Optional (e.g., 100 GiB)
3. Upload files to the file share or connect via PowerShell/Windows Explorer.
4. From the portal, go to **File Share** → **Connect** → Copy the PowerShell script:
   ```powershell
   net use Z: \\<storage>.file.core.windows.net\<fileshare> /user:Azure\<account_name> <key>
   ```
5. Run the script to map the file share as a network drive from a VM or local system.

---

## Step 9: Azure File Sync
1. Go to [Azure Portal](https://portal.azure.com) → Search for **Azure File Sync** → Click **Create**.
2. Create an **Azure File Sync Service**.
3. On an on-premises VM or Azure VM, download and install the [Azure File Sync Agent](https://docs.microsoft.com/azure/storage/files/storage-sync-files-deployment-guide).
4. Register the VM with the Azure File Sync Service.
5. Create a **Sync Group** and link it to the `testfileshare` file share.
6. This enables hybrid cloud storage, where hot files stay local and cold files sync to the cloud.

---

## Resources
- [Azure Master Class v2 - Module 5 - Storage
](https://www.youtube.com/watch?v=E1t-x0T2bn0)
- [Azure Blob Storage Documentation](https://docs.microsoft.com/azure/storage/blobs/)
- [Azure File Share Documentation](https://docs.microsoft.com/azure/storage/files/)
- [Azure File Sync Deployment Guide](https://docs.microsoft.com/azure/storage/files/storage-sync-files-deployment-guide)
- [Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/)
