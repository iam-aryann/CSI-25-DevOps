# Task 1: File Permissions

## Description
Create a file named `aryan.txt`, assign permissions (read, write, execute) to different user categories (owner, group, others), and practice changing permissions using `chmod`.

---

## Instructions

### 1. Create the File
```bash
touch aryan.txt
```

---

### 2. Assign Permissions
Set the following permissions:

- **Owner (User):** Read, write, execute (`rwx`)
- **Group:** Read, execute (`r-x`)
- **Others:** Read only (`r--`)

**Numeric Mode: `754`**

- `7` (Owner): `r` (4) + `w` (2) + `x` (1) = 7  
- `5` (Group): `r` (4) + `-` (0) + `x` (1) = 5  
- `4` (Others): `r` (4) + `-` (0) + `-` (0) = 4

Apply the permissions using:
```bash
chmod 754 aryan.txt
```

---

### 3. Verify Permissions
Use the following command to check:
```bash
ls -l aryan.txt
```

**Example output:**
```
-rwxr-xr--. 1 root root 0 May 23 14:50 aryan.txt
```

**Breakdown of `-rwxr-xr--`:**

- `-` : File type (regular file)  
- `rwx` : Owner permissions (read, write, execute)  
- `r-x` : Group permissions (read, execute)  
- `r--` : Others permissions (read)

---

## Resources

- [YouTube: Understanding File Permissions](https://www.youtube.com/watch?v=iwolPf6kN-k)  
- [Pluralsight: Linux File Permissions](https://www.pluralsight.com/blog/it-ops/linux-file-permissions)
