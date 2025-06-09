# Task 5: Practice More Linux Commands

## Description
Practice more Linux commands to enhance command-line proficiency. This task includes commands for file and directory manipulation, system info, network management, compression, and more.

## Instructions and Commands

### 1. **System Information**

```sh
uname -a       # Display all system info
hostname       # Show or set the system's hostname
uptime         # Show system uptime and load average
```

### 2. **Disk Usage and Free Space**

```sh
df -h                      # Disk usage (human-readable)
du -sh /path/to/directory  # Total size of a directory
```

### 3. **File Operations**

```sh
file filename    # Identify file type
stat filename    # Detailed file info
```

### 4. **Searching and Finding Files**

```sh
find /path -name filename                    # Find files by name
grep "search_term" filename                  # Search for a term in file
grep -r "search_term" /path/to/directory     # Recursive search in directory
```

### 5. **Process Management**

```sh
ps aux        # Show all running processes
top           # Interactive process viewer
kill PID      # Kill process by PID
```

### 6. **Network Management**

```sh
ifconfig                 # Show network interfaces (older distros)
ip addr show             # Show IP addresses and interfaces
ping hostname            # Ping a host
netstat -tuln            # Show active listening ports
```

### 7. **Compression and Archiving**

```sh
tar -czvf archive.tar.gz /path/to/directory  # Compress to .tar.gz
tar -xzvf archive.tar.gz                     # Extract .tar.gz
zip -r archive.zip /path/to/directory        # Compress to .zip
unzip archive.zip                            # Extract .zip
```

### 8. **Text Manipulation**

```sh
echo "text" > file.txt   # Write text to file
cat file.txt             # View file content
sort file.txt            # Sort lines
wc -l file.txt           # Line count
```

### 9. **Permission Management**

```sh
chmod 644 file.txt         # Set file permissions
chown user:group file.txt  # Change file owner/group
```

### 10. **Miscellaneous Commands**

```sh
history                  # View command history
alias ll='ls -la'        # Create a shortcut for ls -la
date                     # Show or set system date/time
```

## Resources
* Linux Tutorial – JavaTpoint
* Linux Command Library
* YouTube – Linux Basics
