## Task 5: Create a Linux/Windows Self-Hosted Agent in Azure DevOps

**Objective**:  
Set up a self-hosted build agent on a Linux or Windows machine to run Azure DevOps pipelines, providing full control over the environment and avoiding Microsoft-hosted agent limitations.

---

## Prerequisites
- An Azure DevOps organization and project (e.g., from Week 7, Task 1).
- Project Administrator or Agent Pool Administrator permissions.
- A target machine (Linux or Windows) with internet access.
- Basic knowledge of command-line tools (PowerShell for Windows, Bash for Linux).

---

## Why Use a Self-Hosted Agent?
- **Full Control**: Customize the environment with pre-installed tools and libraries.
- **No Time Limits**: Unlike Microsoft-hosted agents (1800 mins/month free tier).
- **Performance**: Ideal for enterprise builds or resource-intensive tasks.

---

## Steps to Set Up a Self-Hosted Agent

### Step 1: Create a Personal Access Token (PAT)
1. Go to **Azure DevOps** > **User settings** (top-right, under profile) > **Security** > **Personal Access Tokens**.
2. Click **New Token** and configure:
   - **Organization**: Select your organization.
   - **Scopes**: Select **Agent Pools** → **Read & Manage**.
   - **Expiration**: Set as needed (e.g., 30 days).
3. Click **Create** and copy the PAT (store securely; it won’t be shown again).

---

### Step 2: Prepare the Target Machine

#### Windows
1. Install prerequisites:
   - **Git for Windows**: Download from [git-scm.com](https://git-scm.com).
   - **PowerShell 5.1 or later**: Verify with `powershell -version`.
2. Ensure the machine has internet access.

#### Linux
1. Install prerequisites (e.g., on Ubuntu):
   ```bash
   sudo apt update && sudo apt install -y git curl tar
   ```
2. Ensure the machine has internet access.

---

### Step 3: Download Agent Package
1. In your Azure DevOps project, go to **Project Settings** > **Agent Pools** > **Default**.
2. Click **New Agent** and select the OS (**Windows** or **Linux**).
3. Download the agent package (zip for Windows, tarball for Linux).

---

### Step 4: Install and Configure the Agent

#### Windows Agent Installation
1. Extract the downloaded zip to a directory (e.g., `C:\agent`):
   ```powershell
   cd C:\agent
   ```
2. Configure the agent:
   ```powershell
   .\config.cmd
   ```
   - Provide:
     - **Server URL**: `https://dev.azure.com/your-org` (replace `your-org` with your organization name).
     - **PAT**: Paste the token from Step 1.
     - **Agent Pool**: `Default` (or a custom pool).
     - **Agent Name**: `MyWindowsAgent`.
     - **Work Folder**: `_work` (default).
3. Run the agent:
   ```powershell
   .\run.cmd
   ```
4. (Optional) Install as a Windows service:
   ```powershell
   .\svc install
   .\svc start
   ```

#### Linux Agent Installation
1. Create a directory and extract the tarball:
   ```bash
   mkdir myagent && cd myagent
   curl -O https://vstsagentpackage.azureedge.net/agent/2.220.2/vsts-agent-linux-x64-2.220.2.tar.gz
   tar zxvf vsts-agent-linux-x64-2.220.2.tar.gz
   ```
2. Configure the agent:
   ```bash
   ./config.sh
   ```
   - Provide:
     - **Server URL**: `https://dev.azure.com/your-org` (replace `your-org` with your organization name).
     - **PAT**: Paste the token from Step 1.
     - **Agent Pool**: `Default` (or a custom pool).
     - **Agent Name**: `MyLinuxAgent`.
     - **Work Folder**: `_work` (default).
3. Run the agent:
   ```bash
   ./run.sh
   ```
4. (Optional) Install as a service (e.g., Ubuntu with systemd):
   ```bash
   sudo ./svc.sh install
   sudo ./svc.sh start
   ```

---

### Step 5: Verify the Agent
1. Go to **Project Settings** > **Agent Pools** > **Default** in Azure DevOps.
2. Confirm the agent (`MyWindowsAgent` or `MyLinuxAgent`) is listed and shows as online.

---

### YAML Pipeline Example to Use Self-Hosted Agent
1. Create or edit a YAML pipeline (e.g., `azure-pipelines.yml`):
   ```yaml
   pool:
     name: Default
     demands:
       - agent.name -equals MyWindowsAgent  # Replace with MyLinuxAgent for Linux

   steps:
     - script: echo "Running on self-hosted agent"
       displayName: 'Test self-hosted agent'
   ```
---

## References
- [YouTube: Azure DevOps Test Plans & Agents](https://www.youtube.com/results?search_query=azure+devops+self+hosted+agent)
- [YouTube: Azure DevOps Test Plans | Test Plans | Test Suites | Edureka
](https://www.youtube.com/watch?v=Cu7zx9u1sOE)
- [Microsoft Docs: Linux Agents](https://learn.microsoft.com/azure/devops/pipelines/agents/linux-agent?view=azure-devops)
- [Microsoft Docs: Windows Agents](https://learn.microsoft.com/azure/devops/pipelines/agents/windows-agent?view=azure-devops)
