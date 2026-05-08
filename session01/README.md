VOH-W01-T01  ·  Bootstrap Your Engineering Workstation — WSL2 Ubuntu Environment Setup

Week 1  ·  Day 1  ·  Linux Foundation & Workstation Setup
🏢 Business Scenario	You have just joined the VOH Platform Engineering team as a Junior Cloud Engineer. Your team lead has raised a ticket: every engineer must have a standardised Ubuntu workstation configured before being granted access to production systems. You must provision your local WSL2 environment to match the team standard.

💥 Business Impact	Without a correctly configured workstation, you cannot contribute to any engineering tasks, cannot access shared GitHub repositories, and will block other onboarding activities. This is a BLOCKER for all subsequent tickets.

⏱ SLA Expectation	
Resolution within 3 hours. 
Workstation must pass all validation checks before EOD.

🔧 Required Tools	
WSL2, Ubuntu 22.04 LTS, Git, GitHub CLI, Vim/Nano, curl, wget, tree, htop, net-tools, Python 3

⏳ Estimated Duration	2–3 hours

  ● SEVERITY: HIGH  

🎯 Technical Objectives
•	Install and configure WSL2 with Ubuntu 22.04 LTS on Windows
•	Configure a professional Bash shell environment (.bashrc, aliases, prompt)
•	Install and verify all core engineering CLI tools
•	Set up SSH key pair and authenticate with GitHub
•	Configure Git global identity and sign your first commit
•	Document your workstation setup in a professional README.md

📋 Prerequisites
•	Windows 10 version 2004+ or Windows 11
•	Administrator access to your Windows machine
•	A GitHub account (free tier)
•	Internet connection

🔩 Engineering Tasks
1.	Enable WSL2 feature via PowerShell as Administrator and reboot
2.	Install Ubuntu 22.04 LTS from Microsoft Store and complete first-run setup
3.	Run full system update: sudo apt update && sudo apt upgrade -y
4.	Install engineering tools: git, curl, wget, vim, nano, tree, htop, net-tools, python3, python3-pip, unzip, jq
5.	Install GitHub CLI (gh) and authenticate with your GitHub account
6.	Generate an SSH key pair (ED25519 algorithm) and add the public key to GitHub
7.	Configure Git global username and email matching your GitHub account
8.	Create a professional .bashrc with custom PS1 prompt, useful aliases (ll, la, cls), and PATH exports
9.	Create your first GitHub repository: voh-engineering-journal
10.	Write a README.md documenting your workstation setup and push to GitHub

💻 Step-by-Step Commands
# === STEP 1: Enable WSL2 (run in PowerShell as Admin) ===
wsl --install
wsl --set-default-version 2

# === STEP 2: Update Ubuntu system ===
sudo apt update && sudo apt upgrade -y

# === STEP 3: Install engineering toolkit ===
sudo apt install -y git curl wget vim nano tree htop net-tools \
  python3 python3-pip unzip jq build-essential

# === STEP 4: Install GitHub CLI ===
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
  https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install gh -y

# === STEP 5: Generate SSH key ===
ssh-keygen -t ed25519 -C "your@email.com" -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ssh-agent -s && ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub  # Copy this to GitHub SSH keys

# === STEP 6: Configure Git ===
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global init.defaultBranch main
git config --global core.editor vim

# === STEP 7: Test GitHub SSH connection ===
ssh -T git@github.com

# === STEP 8: Create GitHub repo and push ===
gh repo create voh-engineering-journal --public
mkdir ~/voh-engineering-journal && cd ~/voh-engineering-journal
git init && git remote add origin git@github.com:USERNAME/voh-engineering-journal.git
echo '# VOH Engineering Journal' > README.md
git add . && git commit -m 'VOH-W01-T01: Initialize engineering journal'
git push -u origin main

# === VALIDATION ===
git --version && python3 --version && gh --version && ssh -T git@github.com

✅ Validation Steps
•	Run: uname -a — should show Linux kernel with Ubuntu 22.04
•	Run: git --version — should show git 2.x.x
•	Run: ssh -T git@github.com — should show 'Hi USERNAME! You've successfully authenticated'
•	Run: gh auth status — should show 'Logged in to github.com'
•	Run: python3 --version — should show Python 3.10+
•	Check GitHub: voh-engineering-journal repo exists with README.md
•	Confirm .bashrc has been customised with aliases and PS1 prompt

🔥 Troubleshooting Scenarios
Problem: WSL2 command not found after running wsl --install
Fix: Your Windows version may not support WSL2. Check version with winver. Upgrade to Windows 10 2004+ or enable via Control Panel → Programs → Turn Windows features on or off → Windows Subsystem for Linux.

Problem: ssh -T git@github.com returns 'Permission denied (publickey)'
Fix: Your SSH key has not been added to GitHub. Run: cat ~/.ssh/id_ed25519.pub, copy the output, go to GitHub → Settings → SSH Keys → New SSH Key, paste and save. Then re-run ssh-add ~/.ssh/id_ed25519.

Problem: apt update fails with 'connection timed out' errors
Fix: WSL2 DNS may be broken. Run: echo 'nameserver 8.8.8.8' | sudo tee /etc/resolv.conf. If WSL is behind a corporate proxy, configure /etc/apt/apt.conf.d/proxy.conf with your proxy settings.

Problem: git push fails with 'remote: Support for password authentication was removed'
Fix: GitHub removed password auth in 2021. You must use SSH (recommended) or a Personal Access Token. Verify your remote is using SSH: git remote -v. If it shows https://, change it: git remote set-url origin git@github.com:USERNAME/REPO.git

📦 Expected Deliverables
•	Fully configured WSL2 Ubuntu 22.04 environment with all tools installed
•	SSH key pair generated and public key uploaded to GitHub
•	Git globally configured with correct identity
•	Custom .bashrc with professional prompt and aliases
•	README.md documenting the workstation setup process
•	Screenshot showing successful: ssh -T git@github.com

🐙 GitHub Deliverables
•	Repository: voh-engineering-journal (public)
•	File: README.md — Workstation Setup Guide
•	File: screenshots/ssh-auth-success.png
•	File: dotfiles/.bashrc — your custom shell config
•	Commit message format: VOH-W01-T01: [description]

📝 Documentation Requirements
README.md must include: System specs, tools installed with versions, installation commands used
Document any errors encountered and how you resolved them
Include a 'Lessons Learned' section
Include version output screenshots for git, python3, and gh

🏗 Architecture Diagram Requirement
Draw a simple diagram showing: Windows → WSL2 → Ubuntu 22.04 → Git → SSH → GitHub. Include the network flow for SSH authentication. Use draw.io (free) or ASCII art in the README.
🎤 Interview Questions
What is WSL2 and how does it differ from WSL1? What changed in the virtualisation model?
Why do we use ED25519 SSH keys instead of RSA? What are the cryptographic advantages?
What is the difference between git config --global and --local? When would you use each?
Why did GitHub deprecate password authentication? What replaced it?
What does eval $(ssh-agent -s) do and why is it required?

⚠️ Common Mistakes to Avoid
Using RSA 2048-bit keys instead of ED25519 — ED25519 is faster and more secure
Committing with wrong git identity — always verify git config --list before first commit
Leaving SSH keys unprotected with no passphrase in shared/professional environments
Not configuring .bashrc — a bare prompt slows down all future work
Using HTTPS remotes instead of SSH — SSH is required for automated workflows

🚀 Stretch Goals
•	Configure Zsh with Oh-My-Zsh and the Powerlevel10k theme for an advanced shell experience
•	Set up Windows Terminal with custom colour scheme and WSL2 profile as default
•	Configure SSH config file (~/.ssh/config) with shortcuts for GitHub and future cloud hosts
•	Write a bootstrap.sh script that automates the entire workstation setup (idempotent)
•	Add pre-commit hooks to your repo to enforce conventional commit message format

🌍 Real-World Engineering Relevance
Every cloud engineering team requires standardised developer environments. At companies like Atlassian, HashiCorp, and AWS, onboarding checklists are identical to this ticket. Automating environment setup (your stretch goal) is how senior engineers eliminate onboarding friction and ensure consistency across distributed teams.

 
