## Task 6: Create a Custom Docker Bridge Network

**Objective**:  
Understand and implement custom Docker networking by creating a user-defined bridge network, connecting containers to it, and enabling communication between containers by name.

---

## Step-by-Step Instructions

### Step 1: Create a Custom Bridge Network
1. Create a user-defined bridge network:
   ```bash
   docker network create --driver bridge custom-bridge
   ```
2. Verify the network was created:
   ```bash
   docker network ls
   ```
   You should see `custom-bridge` listed among the networks.

---

### Step 2: Run Containers Attached to the Same Network
1. Run the first container:
   ```bash
   docker run -dit --name container1 --network custom-bridge ubuntu
   ```
2. Run the second container:
   ```bash
   docker run -dit --name container2 --network custom-bridge ubuntu
   ```

---

### Step 3: Install ping Utility
1. Access `container1`:
   ```bash
   docker exec -it container1 bash
   ```
2. Inside `container1`, install the `ping` utility:
   ```bash
   apt update && apt install iputils-ping -y
   ```
3. Exit `container1`:
   ```bash
   exit
   ```
4. Repeat the above steps for `container2` to ensure both containers have `ping` installed.

---

### Step 4: Test Inter-Container Communication
1. Access `container1` again:
   ```bash
   docker exec -it container1 bash
   ```
2. From inside `container1`, ping `container2` by name:
   ```bash
   ping container2
   ```
3. You should see successful ping replies, indicating that DNS resolution works between containers on the custom bridge network.

---

## Notes
- Containers on the **default bridge network** cannot resolve each other by name. A custom bridge network enables this functionality.
- Inspect the network for details:
  ```bash
  docker network inspect custom-bridge
  ```

---

## Expected Outcome
- A custom bridge network (`custom-bridge`) is created.
- Two containers (`container1` and `container2`) are connected to the custom network.
- Containers can communicate with each other using their names (e.g., `ping container2` from `container1`).

---

## Resources
- [YouTube: Docker Networking Tutorial | Container Network Model | Docker Tutorial For Beginners | Simplilearn
](https://www.youtube.com/watch?v=c6Ord0GAOp8)
- [Docker Curriculum](https://docker-curriculum.com/)
- [Docker Networking Documentation](https://docs.docker.com/network/)
