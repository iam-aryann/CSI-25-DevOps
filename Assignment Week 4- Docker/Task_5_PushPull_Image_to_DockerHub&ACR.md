## Task 5: Push and Pull Docker Images to Docker Hub and Azure Container Registry (ACR)

**Objective**:  
Learn to push and pull Docker images to/from Docker Hub and Azure Container Registry (ACR).

---

## Part A: Push & Pull Docker Image from Docker Hub

### Step 1: Login to Docker Hub
1. Log in to your Docker Hub account:
   ```bash
   docker login
   ```
2. Enter your Docker Hub username and password when prompted.

### Step 2: Tag Your Image
1. Tag the local image (e.g., `myapp`) for Docker Hub:
   ```bash
   docker tag myapp <your-dockerhub-username>/myapp:latest
   ```

### Step 3: Push the Image
1. Push the tagged image to Docker Hub:
   ```bash
   docker push <your-dockerhub-username>/myapp:latest
   ```

### Step 4: Pull the Image (On Any System)
1. Pull the image from Docker Hub to verify:
   ```bash
   docker pull <your-dockerhub-username>/myapp:latest
   ```

---

## Part B: Push & Pull Docker Image from Azure Container Registry (ACR)

### Step 1: Create an ACR (Azure Portal or CLI)
1. Using Azure CLI, create an Azure Container Registry:
   ```bash
   az acr create --resource-group <your_rg> --name <youracrname> --sku Basic
   ```
   - Replace `<your_rg>` with your resource group name.
   - Replace `<youracrname>` with a globally unique ACR name (e.g., `myacr123`).

2. Alternatively, in the Azure Portal:
   - Go to **Container Registries** → Click **+ Create**.
   - Configure:
     - **Resource Group**: Select or create one
     - **Registry Name**: `<youracrname>`
     - **SKU**: Basic
     - **Region**: Choose a region
   - Click **Review + Create** → **Create**.

### Step 2: Login to ACR
1. Log in to your ACR:
   ```bash
   az acr login --name <youracrname>
   ```

### Step 3: Tag the Image for ACR
1. Tag the local image for ACR:
   ```bash
   docker tag myapp <youracrname>.azurecr.io/myapp:latest
   ```

### Step 4: Push to ACR
1. Push the tagged image to ACR:
   ```bash
   docker push <youracrname>.azurecr.io/myapp:latest
   ```

### Step 5: Pull from ACR
1. Pull the image from ACR to verify:
   ```bash
   docker pull <youracrname>.azurecr.io/myapp:latest
   ```

---

## Best Practices
- Use specific version tags (e.g., `v1.0.0`) instead of `latest` in production for consistency.
- Regularly clean up unused tags and repositories to save space and reduce clutter.
- Use ACR for private image hosting, especially for Azure-integrated deployments.

---

## Expected Outcome
- Successfully pushed and pulled a Docker image (`myapp`) to/from Docker Hub.
- Created an Azure Container Registry and pushed/pulled the same image to/from ACR.
- Applied best practices for tagging and managing container images.

---

## Resources
- [YouTube: Push Docker Image to DockerHub/ACR](https://www.youtube.com/results?search_query=push+docker+image+to+dockerhub+acr)
- [Docker Curriculum](https://docker-curriculum.com/)
- [Docker Documentation](https://docs.docker.com/)
- [Azure Container Registry Documentation](https://learn.microsoft.com/azure/container-registry/)
