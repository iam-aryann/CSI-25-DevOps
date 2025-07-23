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

