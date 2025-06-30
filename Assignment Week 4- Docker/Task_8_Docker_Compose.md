## Task 8: Docker Compose for Multi-Container Applications & Docker Security Best Practices

**Objective**:  
- Use Docker Compose to manage a multi-container application.
- Apply Docker security best practices to enhance container security.

---

## Part A: Docker Compose for Multi-Container Applications

### Step 1: Create a Project Directory
```bash
mkdir docker-compose-app
cd docker-compose-app
```

### Step 2: Create Application Files
1. Create `app.py` (a simple Flask application):
   ```python
   from flask import Flask
   app = Flask(__name__)

   @app.route('/')
   def home():
       return "Hello from Flask app running in Docker Compose!"

   if __name__ == '__main__':
       app.run(host='0.0.0.0', port=5000)
   ```
2. Create `requirements.txt`:
   ```
   flask
   ```
3. Create `Dockerfile`:
   ```dockerfile
   FROM python:3.9
   WORKDIR /app
   COPY . .
   RUN pip install -r requirements.txt
   CMD ["python", "app.py"]
   ```

### Step 3: Create `docker-compose.yml`
```yaml
version: '3'
services:
  web:
    build: .
    ports:
      - "5000:5000"
```

### Step 4: Build and Run the App
1. Build and start the application:
   ```bash
   docker-compose up --build
   ```
2. Visit [http://localhost:5000](http://localhost:5000) in your browser to see "Hello from Flask app running in Docker Compose!".

### Step 5: Stop the Application
```bash
docker-compose down
```

---

## Part B: Docker Security Best Practices

### 1. Run as Non-Root User
Modify the `Dockerfile` to run the container as a non-root user:
```dockerfile
FROM python:3.9
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
RUN useradd -m appuser
USER appuser
CMD ["python", "app.py"]
```

### 2. Use Minimal Base Images
Use lightweight base images like `python:3.9-slim` or `python:3.9-alpine` to reduce the attack surface:
```dockerfile
FROM python:3.9-slim
```

### 3. Do Not Store Secrets in Images
- Avoid hardcoding credentials in the `Dockerfile` or `docker-compose.yml`.
- Use environment variables or Docker secrets. Example in `docker-compose.yml`:
  ```yaml
  version: '3'
  services:
    web:
      build: .
      ports:
        - "5000:5000"
      environment:
        - API_KEY=${API_KEY}
  ```

### 4. Use .dockerignore File
Create a `.dockerignore` file to exclude sensitive or unnecessary files:
```
.env
*.pyc
__pycache__/
```

### 5. Regularly Scan Images
Scan your Docker images for vulnerabilities:
```bash
docker scan <image-name>
```

---

## Summary
- **Docker Compose**: Simplifies the management of multi-container applications, demonstrated with a Flask app.
- **Security Best Practices**: Applied non-root user, minimal base images, secure secret management, `.dockerignore`, and image scanning to minimize vulnerabilities.

---

## Expected Outcome
- A Flask application is deployed using Docker Compose, accessible at [http://localhost:5000](http://localhost:5000).
- Docker security best practices are implemented to enhance container security.

---

## Resources
- [YouTube: Docker Compose Tutorial
](https://www.youtube.com/watch?v=HG6yIjZapSA)
- [Docker Curriculum](https://docker-curriculum.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Docker Security Best Practices](https://docs.docker.com/engine/security/)
