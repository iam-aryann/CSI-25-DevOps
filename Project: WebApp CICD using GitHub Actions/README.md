# WebApp CI/CD Using GitHub Actions & Azure Web App

## Overview
This project demonstrates an automated CI/CD pipeline that builds and deploys a **Spring Boot Java web application** to **Azure App Service** using **GitHub Actions**. The workflow is designed to help teams ship updates quickly, reliably, and securely.

---

## Business Problem Statement

A leading pharmaceutical company needs to streamline the deployment process for its customer-facing web application. The application delivers critical product information, including usage instructions and safety precautions. Delays or failures in deployment risk outdated or incorrect information reaching healthcare providers and customers.

To ensure rapid, reliable updates, the company chooses to leverage **Azure Web App services** for hosting and **GitHub Actions** for automated build, test, and deployment workflows.

---

## Prerequisites

Before starting, ensure you have:

- An **Azure account** with permissions to create App Service resources.
- A **Dockerized sample Spring Boot Java application** (or WAR-packaged app).
- A **GitHub repository** containing the application source code.
- Azure Web App Publish Profile (or Azure OIDC / Service Principal credentials).
- Optional: GitHub Container Registry (GHCR) or Azure Container Registry (ACR) if deploying container images.

---

## High-Level Architecture

The CI/CD flow is divided into two phases: **Build** and **Deploy**.

**Build Phase (GitHub Actions runner):**
1. Checkout source from GitHub.
2. Install dependencies, test, and build the Spring Boot app (Maven/Gradle).
3. Build a Docker image (if containerized).
4. Authenticate to container registry.
5. Push image to **GitHub Container Registry (GHCR)** or another registry.

**Deploy Phase (Azure):**
1. Azure Web App pulls the published artifact (WAR/JAR) *or* pulls the container image.
2. Application is started and made available publicly.

> _Diagram placeholder — add your PNG here:_  
> `![High-Level Architecture](images/high-level-architecture.png)`

---

## CI/CD Process

Follow these steps to implement the complete workflow:

1. **Create a GitHub repository** for the Spring Boot Java application.
2. **Set up an Azure App Service** (Linux or Windows; Code or Container).
3. **Create a GitHub Actions workflow** (`.github/workflows/azure-webapp.yml`).
4. **Configure triggers** for automatic workflow execution (on push to `main`, pull requests, etc.).
5. **Define workflow steps**:
   - Checkout repository.
   - Set up Java.
   - Build & test application (Maven/Gradle).
   - (Optional) Build Docker image.
   - Log in to registry (GHCR / ACR).
   - Push image or publish artifact.
   - Deploy to Azure Web App.
6. **Store sensitive information** (publish profile, credentials, registry token) in **GitHub Secrets**.
7. **Test and validate** the deployment workflow.
8. **Integrate monitoring and logging** in Azure App Service (App Insights recommended).

---

## GitHub Secrets to Configure

At minimum, add the following repo secrets:

| Secret Name                       | Description                                               |
|----------------------------------|-----------------------------------------------------------|
| `AZURE_WEBAPP_PUBLISH_PROFILE`   | Export from Azure Web App > Get publish profile (XML).    |
| `REGISTRY_USERNAME` (optional)   | GHCR / ACR username.                                      |
| `REGISTRY_PASSWORD` (optional)   | GHCR / ACR token/password.                                |

---

## Workflow 1: Build & Deploy Code (WAR/JAR) to Azure Web App

> Use this if your Azure Web App is configured for **Java (Code)** runtime (no custom container).

```yaml
name: Build and Deploy Spring Boot App to Azure Web App

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Set up JDK
        uses: actions/setup-java@v3
        with:
          distribution: temurin
          java-version: '17'

      - name: Build with Maven
        run: mvn -B clean package

      # Adjust artifact path if packaging JAR vs WAR
      - name: Deploy to Azure Web App
        uses: azure/webapps-deploy@v2
        with:
          app-name: YOUR_WEBAPP_NAME
          publish-profile: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}
          package: target/*.war

# Workflow 2: Container Build & Deploy via GitHub Container Registry (GHCR)

This workflow outlines the process to build a containerized Java application (e.g., a Spring Boot app) and deploy it to an Azure Web App using GitHub Actions and GitHub Container Registry (GHCR).

---

## Steps to Implement

### 1. Create GitHub Actions Workflow
1. Create a file named `.github/workflows/azure-webapp.yml` in your repository:
   ```yaml
   name: Build Container & Deploy to Azure Web App (Container)

   on:
     push:
       branches: [ "main" ]

   env:
     IMAGE_NAME: ghcr.io/${{ github.repository_owner }}/pharma-webapp

   jobs:
     build-push-deploy:
       runs-on: ubuntu-latest
       permissions:
         contents: read
         packages: write
         id-token: write

       steps:
         - name: Checkout
           uses: actions/checkout@v3

         - name: Log in to GHCR
           uses: docker/login-action@v3
           with:
             registry: ghcr.io
             username: ${{ github.repository_owner }}
             password: ${{ secrets.GITHUB_TOKEN }}

         - name: Build and Push Image
           uses: docker/build-push-action@v5
           with:
             context: .
             push: true
             tags: ${{ env.IMAGE_NAME }}:latest

         - name: Deploy Container to Azure Web App
           uses: azure/webapps-deploy@v2
           with:
             app-name: YOUR_WEBAPP_NAME
             publish-profile: ${{ secrets.AZURE_WEBAPP_PUBLISH_PROFILE }}
             images: ${{ env.IMAGE_NAME }}:latest
   ```
   - Replace `YOUR_WEBAPP_NAME` with your Azure Web App name.
   - Ensure `AZURE_WEBAPP_PUBLISH_PROFILE` is added as a secret in your GitHub repository settings.

---

### 2. Local Build Test (Optional)
1. Test the application locally before pushing:
   ```bash
   mvn clean package
   docker build -t pharma-webapp .
   docker run -p 8080:8080 pharma-webapp
   ```
2. Verify the app in a browser at `http://localhost:8080`.

---

### 3. Azure App Service Setup
1. Go to the [Azure Portal](https://portal.azure.com) and create a Web App:
   - **Publish**: Select **Docker Container**.
   - **Runtime Stack**: Choose **Java 17** and **Java SE** (for JAR) or **Tomcat** (for WAR).
   - **Region**: Select your preferred region.
   - **Pricing Plan**: Choose an appropriate plan (e.g., Free F1 for testing).
2. Configure the **Startup Command** (if needed for your container, e.g., `java -jar app.jar` for Java SE).
3. Download the **Publish Profile** from the Web App’s **Overview** page and add it as a GitHub secret (`AZURE_WEBAPP_PUBLISH_PROFILE`).

---

### 4. Monitoring & Logging
1. After deployment:
   - Enable **Application Insights** in the Azure Web App for metrics, failure tracking, and performance monitoring.
   - Use **Log Stream** in the Azure Web App portal to view live container logs.
   - Configure alerts for failed deployments or availability issues under **Monitoring** > **Alerts**.

---

### 5. Push Code and Verify
1. Commit and push the workflow file and application code to the `main` branch:
   ```bash
   git add .
   git commit -m "Add GitHub Actions workflow for container build and deploy"
   git push origin main
   ```
2. Monitor the build in **Actions** tab of your GitHub repository.
3. Verify the app is accessible at the Azure Web App URL (e.g., `https://<your-webapp-name>.azurewebsites.net`).

---

## Repository Structure
```
pharma-webapp/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/pharmawebapp/
│   │   │       ├── PharmaWebAppApplication.java
│   │   │       └── controllers/
│   │   │           └── HomeController.java
│   │   └── resources/
│   │       ├── application.properties
│   │       └── templates/
│   │           └── index.html
│   └── test/
│       └── java/
│           └── com/example/pharmawebapp/
│               └── PharmaWebAppApplicationTests.java
│
├── .github/
│   └── workflows/
│       ├── azure-webapp.yml
│       └── docker-deploy.yml (optional)
│
├── Dockerfile (optional)
├── mvnw
├── mvnw.cmd
├── pom.xml
└── README.md
```

---

## Deliverables Checklist
| **Item** | **Done (✔)** |
|----------|--------------|
| GitHub repo created and source pushed | ✔ |
| Azure Web App provisioned | ✔ |
| Secrets added in GitHub | ✔ |
| GitHub Actions workflow committed | ✔ |
| Successful build run observed | ✔ |
| App reachable at Azure Web App URL | ✔ |
| Monitoring configured (optional) | ✔ |

---

##  Summary
This workflow automates the build and push of a containerized Java application to GHCR and deploys it to an Azure Web App. It ensures seamless CI/CD, with monitoring via Application Insights and logs for debugging.

---

## Resources
- [Azure Docs: Deploy to App Service from GitHub Actions](https://learn.microsoft.com/en-us/azure/app-service/deploy-github-actions)
- [Medium: Deploy Spring Boot Java App to Azure Web App using GitHub Actions](https://medium.com/@kharvingaraj1/deploying-a-spring-boot-java-application-to-azure-app-service-using-github-actions-9d03405380bf)
