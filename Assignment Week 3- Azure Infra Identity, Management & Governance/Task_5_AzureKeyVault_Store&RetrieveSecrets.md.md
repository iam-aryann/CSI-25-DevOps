# Task 5: Azure Key Vault – Store and Retrieve Secrets

**Objective**:  
Create an Azure Key Vault, store secrets, configure access policies, and retrieve secrets using the Azure CLI.

---

## Pre-requisites
- Access to the [Azure Portal](https://portal.azure.com)
- Azure CLI installed or use [Azure Cloud Shell](https://shell.azure.com)
- Logged into your Azure account:
  ```bash
  az login
  ```
- Sufficient permissions (Owner or Contributor role)

---

## Steps

### 1. Create a Key Vault

#### Using Azure Portal
1. Go to [Azure Portal](https://portal.azure.com) → Search for **Key Vaults** → Click **+ Create**.
2. Configure:
   - **Subscription**: Select your subscription
   - **Resource Group**: Select or create one
   - **Key Vault Name**: Globally unique (e.g., `mykeyvault123`)
   - **Region**: Choose a nearby region
   - **Access Configuration**: Select **Vault access policy**
3. Click **Review + Create** → **Create**.

#### Using Azure CLI
```bash
az keyvault create --name <YourKeyVaultName> --resource-group <YourResourceGroup> --location <Region>
```

---

### 2. Store a Secret

#### Portal
1. Go to your **Key Vault** → **Secrets** → Click **Generate/Import**.
2. Configure:
   - **Name**: `MySecret`
   - **Value**: `MySuperSecureValue`
3. Click **Create**.

#### Azure CLI
```bash
az keyvault secret set --vault-name <YourKeyVaultName> --name "MySecret" --value "MySuperSecureValue"
```

---

### 3. Configure Access Policies

#### Portal
1. Go to your **Key Vault** → **Access Policies** → Click **+ Add Access Policy**.
2. Configure:
   - **Secret Permissions**: Select `Get`, `List`, `Set`
   - **Select Principal**: Choose the user or service principal
3. Click **Add** → **Save**.

#### Azure CLI
```bash
az keyvault set-policy --name <YourKeyVaultName> --resource-group <YourResourceGroup> --upn <UserPrincipalName> --secret-permissions get list set
```

---

### 4. Retrieve the Secret Using Azure CLI
```bash
az keyvault secret show --vault-name <YourKeyVaultName> --name "MySecret" --query value -o tsv
```
This command displays the secret value in plain text.

---

## Expected Outcome
- Azure Key Vault successfully created.
- Secrets stored and retrieved using both the Azure Portal and CLI.
- Access policies configured to control secret management and access.

---

## Resources
- [YouTube: Azure Key Vault Full Tutorial](https://www.youtube.com/results?search_query=azure+key+vault+tutorial)
- [Microsoft Docs – Azure Key Vault](https://learn.microsoft.com/azure/key-vault/)
