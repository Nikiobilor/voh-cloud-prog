### VOH-W01-T02  ·  Linux Command-Line Proficiency — File System Navigation & System Administration

### Week 1  ·  Day 2  · 
 ### Linux Foundation & Workstation Setup
🏢 Business Scenario	
A new junior engineer has been given access to a production Linux server but cannot perform basic operational tasks. The team lead has created a training ticket: you must demonstrate proficiency in Linux file system navigation, user management, file permissions, process management, and system monitoring before being granted elevated access.

### 💥 Business Impact	Engineers without Linux CLI proficiency cannot perform any operational, deployment, or troubleshooting tasks. This skill is the absolute foundation of all cloud engineering work.

### ⏱ SLA Expectation	
Complete all Linux proficiency exercises and pass validation within 4 hours.

### 🔧 Required Tools	
Ubuntu 22.04 (WSL2), Bash, vim, nano, htop, ps, top, df, du, chmod, chown, useradd, systemctl

### ⏳ Estimated Duration	3–4 hours

  ● SEVERITY: HIGH  

### 🎯 Technical Objectives ###
•	Navigate the Linux file system confidently using absolute and relative paths
•	Create, move, copy, and delete files and directories using CLI
•	Understand and modify Linux file permissions (chmod, chown, chgrp)
•	Create and manage Linux users and groups
•	Monitor running processes using ps, top, and htop
•	Understand disk usage with df and du
•	Pipe and redirect command output for log analysis
•	Write your first Bash scripts to automate repetitive tasks

### 📋 Prerequisites ###
•	Completed VOH-W01-T01 (WSL2 Ubuntu environment)
•	Access to WSL2 Ubuntu terminal

### 🔩 Engineering Tasks ###
11.	Navigate Linux file system and document the purpose of: /, /etc, /var, /opt, /home, /tmp, /proc, /sys, /usr
12.	Create a structured directory tree: ~/voh-labs/week01/ with subdirectories: logs, configs, scripts, backups
13.	Practice file operations: create, copy, move, rename, delete using: touch, cp, mv, rm, mkdir, rmdir
14.	Investigate file permissions using ls -la and understand the rwxrwxrwx notation
15.	Change file permissions using chmod in both symbolic (u+x) and octal (755) notation
16.	Create a new Linux user (voh-trainee), set a password, and add to sudo group
17.	Monitor processes using ps aux, top, and htop — kill a test process by PID
18.	Analyse disk usage with df -h and du -sh on various directories
19.	Write a system-info.sh Bash script that prints: hostname, OS version, CPU cores, memory, disk usage
20.	Practice I/O redirection: >, >>, |, 2>&1, and use grep, awk, sed, sort, uniq on log files


💻 Step-by-Step Commands
# === FILE SYSTEM EXPLORATION ===
ls -la /              # List root directory with permissions
tree -L 2 /etc        # Tree view of /etc (2 levels deep)
find /var/log -name '*.log' -mtime -1  # Logs modified in last 24h

# === CREATE LAB DIRECTORY STRUCTURE ===
mkdir -p ~/voh-labs/week01/{logs,configs,scripts,backups}
tree ~/voh-labs/

# === FILE OPERATIONS ===
touch ~/voh-labs/week01/configs/app.conf
echo 'environment=production' > ~/voh-labs/week01/configs/app.conf
cp ~/voh-labs/week01/configs/app.conf ~/voh-labs/week01/backups/
mv ~/voh-labs/week01/configs/app.conf ~/voh-labs/week01/configs/app.conf.bak

# === PERMISSIONS ===
ls -la ~/voh-labs/week01/
chmod 755 ~/voh-labs/week01/scripts/    # rwxr-xr-x
chmod 640 ~/voh-labs/week01/configs/app.conf.bak  # rw-r-----
chmod u+x ~/voh-labs/week01/scripts/   # Add execute for owner

# === USER MANAGEMENT ===
sudo useradd -m -s /bin/bash voh-trainee
sudo passwd voh-trainee
sudo usermod -aG sudo voh-trainee
id voh-trainee
grep voh-trainee /etc/passwd

# === PROCESS MANAGEMENT ===
ps aux | grep bash
top -bn1 | head -20
sleep 300 &           # Start background process
jobs                  # See background jobs
kill %1               # Kill background job

# === DISK USAGE ===
df -h                 # All mounted filesystems
du -sh ~/voh-labs/    # Size of your lab directory
du -sh /var/log/*     # Log sizes

# === I/O REDIRECTION & PIPES ===
ps aux > ~/voh-labs/week01/logs/processes.log
cat /etc/passwd | grep -v nologin | awk -F: '{print $1}' > ~/voh-labs/week01/logs/users.log
grep 'sudo' /etc/group

# === SYSTEM INFO SCRIPT ===
cat > ~/voh-labs/week01/scripts/system-info.sh << 'EOF'
#!/bin/bash
echo '=============================='
echo '  VOH System Information'
echo '=============================='
echo "Hostname:   $(hostname)"
echo "OS:         $(lsb_release -d | cut -f2)"
echo "Kernel:     $(uname -r)"
echo "CPU Cores:  $(nproc)"
echo "RAM Total:  $(free -h | awk '/^Mem:/{print $2}')"
echo "Disk Used:  $(df -h / | awk 'NR==2{print $5}')"
echo "Uptime:     $(uptime -p)"
echo '=============================='
EOF
chmod +x ~/voh-labs/week01/scripts/system-info.sh
./~/voh-labs/week01/scripts/system-info.sh

### ✅ Validation Steps ###
•	Run: tree ~/voh-labs/ — should show all 4 subdirectories
•	Run: ls -la ~/voh-labs/week01/scripts/ — verify scripts/ has drwxr-xr-x permissions
•	Run: id voh-trainee — should show uid, gid, and sudo group membership
•	Run: ./~/voh-labs/week01/scripts/system-info.sh — should print all system info cleanly
•	Run: wc -l ~/voh-labs/week01/logs/processes.log — should show > 0 lines
•	Push all scripts and logs to GitHub under week01/ directory


### 🔥 Troubleshooting Scenarios ###
Problem: Permission denied when running chmod or useradd
Fix: You need sudo for system-level commands. Prefix with sudo. If sudo is not configured, run: su - root and then visudo to add your user to the sudoers file.
Problem: tree command not found
Fix: Install it: sudo apt install tree -y. This is common on minimal Ubuntu installs.
Problem: Script runs but shows Permission denied: ./script.sh
Fix: The execute bit is not set. Run: chmod +x script.sh then retry. Verify with ls -l script.sh — you should see -rwxr-xr-x.
Problem: useradd: user 'voh-trainee' already exists
Fix: The user was already created. Skip creation. Check with: id voh-trainee. To delete and recreate: sudo userdel -r voh-trainee then retry.
📦 Expected Deliverables
•	system-info.sh Bash script committed to GitHub
•	Screenshot of: ls -la showing permissions on created directories
•	Screenshot of: htop or top showing running processes
•	logs/processes.log and logs/users.log files committed
•	README.md explaining each Linux command used and why
🐙 GitHub Deliverables
•	Directory: week01/ in voh-engineering-journal repo
•	File: week01/scripts/system-info.sh
•	File: week01/logs/processes.log
•	File: week01/logs/users.log
•	File: week01/README.md — Linux CLI Reference Guide
📝 Documentation Requirements
Create a Linux CLI cheatsheet in your README.md covering: navigation, file ops, permissions, users, processes, disk
Document what each permission (r, w, x) means for files vs directories
Explain the difference between 755, 644, 600 permission modes and when to use each
Document the purpose of: /, /etc, /var, /opt, /tmp in the Linux FHS

🏗 Architecture Diagram Requirement
Draw the Linux File Hierarchy Standard (FHS) tree showing key directories and their purposes. Include a permissions matrix table (rwx notation vs octal). Use ASCII art or draw.io.
🎤 Interview Questions
What is the difference between chmod 755 and chmod u+rwx,go+rx?
What does the sticky bit do? When would you use chmod 1777?
Explain the Linux process lifecycle: what is a zombie process? An orphan process?
What is the difference between ps aux and ps -ef? Which fields are most useful for troubleshooting?
How does Linux file ownership work? What is the difference between owner, group, and others?

⚠️ Common Mistakes to Avoid
Running everything as root — never develop the habit of using root for daily work
Using rm -rf without checking the path — this has destroyed production systems at major companies
Confusing chmod 777 as 'safe' — it grants world-write access and is a security vulnerability
Not using tab completion — this is how professionals work; never type full paths manually
Forgetting to make scripts executable with chmod +x before running

🚀 Stretch Goals
•	Configure /etc/sudoers using visudo to grant voh-trainee passwordless sudo for specific commands only
•	Set up log rotation with logrotate for your lab logs
•	Write a Bash script that archives old logs (>7 days) to a backups/ directory automatically
•	Configure aliases for dangerous commands: alias rm='rm -i' to always prompt before deletion
•	Create a Bash function library sourced from .bashrc with reusable helper functions
🌍 Real-World Engineering Relevance
Linux CLI proficiency is the single most tested skill in Cloud Support and DevOps interviews. Engineers at AWS, Google Cloud, and Azure support teams spend 60–80% of their time in terminals, analysing logs, managing processes, and troubleshooting file system issues. Every subsequent ticket in this program requires these foundations.

