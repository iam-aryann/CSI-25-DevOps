# Week 4: Docker — Containerization & Image Management

## Overview
This week focuses on mastering Docker, covering containerization, image creation, network and storage management, and Docker Compose for orchestrating multi-container applications. It also emphasizes container security and best practices.

---

## Tasks

### Task 1: Introduction to Containerization and Docker Fundamentals
- Understood containerization and how Docker simplifies development and deployment.
- Learned basic Docker concepts: images, containers, layers, and registries.
- Commands practiced:
  ```bash
  docker --version
  docker run hello-world
  docker ps
  docker images
  docker stop <container_id>
  docker rm <container_id>
  docker rmi <image_id>
  ```
- 🔗 [YouTube: Docker Tutorial for Beginners](https://www.youtube.com/results?search_query=docker+tutorial+for+beginners)
- 📘 [Docker Curriculum](https://docker-curriculum.com/)

### Task 2: Docker Installation & Basic Container Operations, Build an Image from Dockerfile
- Installed Docker on Ubuntu/Windows/Mac.
- Performed operations to run, stop, and remove containers.
- Built a Docker image from a custom Dockerfile.
- Commands used:
  ```bash
  docker build -t myimage .
  docker run -d -p 5000:5000 myimage
  ```
- 🔗 [YouTube: Docker Tutorial for Beginners](https://www.youtube.com/results?search_query=docker+tutorial+for+beginners)

### Task 3: Docker Registry, DockerHub, Create a Multi-Stage Build
- Logged into DockerHub and pushed/pulled images.
- Created efficient multi-stage builds to reduce image size.
- Commands:
  ```bash
  docker login
  docker push <username>/myimage:latest
  docker pull <username>/myimage:latest
  ```
- Example multi-stage Dockerfile:
  ```dockerfile
  FROM node:18-alpine AS builder
  # Build stage
  FROM node:18-alpine
  # Runtime stage
  ```
- 🔗 [YouTube: Docker Registry, DockerHub, Multi-Stage Build](https://www.youtube.com/results?search_query=docker+registry+dockerhub+multi+stage+build)

### Task 4: Create Docker Image via Dockerfile & Running Container
- Created a Docker image from a running container using `docker commit`.
- Compared with images built using a Dockerfile.
- Commands:
  ```bash
  docker commit <container_id> mycustomimage
  docker build -t image-name .
  ```
- 🔗 [YouTube: Docker Tutorial for Beginners](https://www.youtube.com/results?search_query=docker+tutorial+for+beginners)

### Task 5: Push and Pull Image to DockerHub and Azure Container Registry (ACR)
- Pushed and pulled Docker images to/from DockerHub and ACR.
- Set up an Azure Container Registry (ACR) via Azure Portal or CLI.
- Commands:
  ```bash
  az acr login --name <registry-name>
  docker tag image <registry-name>.azurecr.io/image
  docker push <registry-name>.azurecr.io/image
  docker pull <registry-name>.azurecr.io/image
  ```
- 🔗 [YouTube: Push Docker Image to DockerHub/ACR](https://www.youtube.com/results?search_query=push+docker+image+to+dockerhub+acr)

### Task 6: Create a Custom Docker Bridge Network
- Understood Docker networking modes.
- Created a custom bridge network and connected multiple containers.
- Commands:
  ```bash
  docker network create --driver bridge my-bridge
  docker run --network my-bridge ...
  ```
- 🔗 [YouTube: Docker Networking](https://www.youtube.com/results?search_query=docker+networking+tutorial)

### Task 7: Create Docker Volume and Mount It to a Container
- Learned data persistence with Docker volumes.
- Commands:
  ```bash
  docker volume create myvol
  docker run -v myvol:/data ...
  ```
- 🔗 [YouTube: Docker Volumes Explained](https://www.youtube.com/results?search_query=docker+volumes+explained)

### Task 8: Docker Compose & Docker Security Best Practices
- Created a multi-container application using `docker-compose.yml`.
- Implemented Docker security best practices:
  - Used minimal base images (e.g., `python:3.9-slim`).
  - Ran containers as non-root users.
  - Used `.dockerignore` to exclude sensitive files.
- Sample `docker-compose.yml`:
  ```yaml
  version: "3"
  services:
    web:
      build: .
      ports:
        - "5000:5000"
  ```
- 🔗 [YouTube: Docker Compose Tutorial](https://www.youtube.com/results?search_query=docker+compose+tutorial)

---

## Tools Used
- Docker Engine
- Docker CLI
- DockerHub
- Azure CLI (for ACR)
- Docker Compose

---
