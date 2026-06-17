# VOH Academy — Phase 1: Foundation
## Session 06: Phase 1 Capstone — Build Your Local Engineering Environment

---

### Watch Before You Start
> **YouTube:** [VOH Academy — Session 02E: Phase 1 Capstone](https://youtu.be/_bHDgkhffVk)
> Watch the video first, then return here to do the lab.

---

### The VOH Story So Far

End of your first week at VOH. Your manager calls a brief review:

> *"You have made it through the foundation week. You know how the file system works, you can edit config files, you understand your shell. Now we are going to test all of it at once. Your task is to set up a local engineering environment from scratch, the same way every new engineer at VOH gets their machine ready on day one. You will also write your first shell script to automate part of the setup. When you are done, you will have a working local environment and a script you can run on any new machine to recreate it."*

This session has no new concepts. It is entirely a practical lab that tests everything you have done so far.

---

### What You Will Build

By the end of this session you will have:

1. A clean, organised workspace structure under `~/voh-cloud-prog/`
2. A fully configured `.bashrc` with your aliases and variables
3. A working `setup.sh` script that automates the environment setup
4. A `session-report.md` file documenting what you did and what you learned

---

### Lab

---

#### Part 1 — Audit Your Current Environment

Before building anything, check what you already have.

Print your shell:
```bash
echo $SHELL
```

Print your environment variables:
```bash
env | sort
```

Print your current aliases:
```bash
alias
```

List your current workspace structure:
```bash
ls -la ~/voh-cloud-prog/
```

Check your `.bashrc` is set up from previous Session:
```bash
cat ~/.bashrc | grep -A 30 "VOH Academy"
```

If your `.bashrc` customisations from previous Session are missing, go back and complete the previous Session before continuing.

---

#### Part 2 — Build the Full Workspace Structure

Your final workspace should look something like this:

```
~/voh-cloud-prog/
├── projects/
│   └── voh-infra/
│       ├── configs/
│       ├── logs/
│       ├── scripts/
│       └── docs/
├── labs/
│   ├── phase-01/
│   ├── phase-02/
│   └── phase-03/
├── notes/
└── bin/
```

Create any directories that are missing:
```bash
mkdir -p ~/voh-cloud-prog/bin
```

The `bin/` folder is where you will put your own scripts so you can run them by name from anywhere.

Verify the full structure:
```bash
find ~/voh-cloud-prog -type d | sort
```

---

#### Part 3 — Write Your First Shell Script

You are going to write a script called `voh-setup.sh` that automates the workspace setup. This means: running the script on a fresh machine should reproduce your entire workspace.

Create the script:
```bash
mkdir  ~/voh-cloud-prog/session-02E/scripts
nano ~/voh-cloud-prog/session-02E/scripts/voh-setup.sh
```

Type this out in full. Read every line as you type it:

```bash
#!/bin/bash
# ============================================================
# VOH Academy — System Setup Script
# Purpose: Update system + install/verify the standard VOH toolset
# Safe to re-run anytime — skips what's already installed/up to date
# ============================================================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log()      { echo -e "${GREEN}[OK]${NC}   $1"; }
log_skip() { echo -e "${YELLOW}[SKIP]${NC} $1"; }
log_err()  { echo -e "${RED}[FAIL]${NC} $1"; }

echo -e "${YELLOW}VOH Academy — System Setup${NC}"
echo "================================="

# ---- Update package list ----
echo ""
echo "Updating package list..."
sudo apt update -qq
log "Package list updated"

# ---- Upgrade existing packages ----
echo ""
echo "Upgrading installed packages..."
sudo apt upgrade -y -qq
log "System packages upgraded"

# ---- Install toolset (idempotent — apt skips already-installed packages) ----
echo ""
echo "Installing VOH standard toolset..."

PACKAGES=(
    curl
    wget
    git
    tree
    htop
    unzip
    jq
    net-tools
    dnsutils
    nmap
    tmux
    build-essential
    python3
    python3-pip
)

for pkg in "${PACKAGES[@]}"; do
    if dpkg -l "$pkg" &>/dev/null && dpkg -l "$pkg" | grep -q "^ii"; then
        log_skip "$pkg already installed"
    else
        if sudo apt install -y -qq "$pkg"; then
            log "$pkg installed"
        else
            log_err "$pkg failed to install"
        fi
    fi
done

# ---- Clean up ----
echo ""
echo "Cleaning up..."
sudo apt autoremove -y -qq
sudo apt clean
log "Cleanup complete"

# ---- Summary ----
echo ""
echo "================================="
echo -e "${GREEN}Setup complete.${NC}"
echo ""
echo "Installed tool versions:"
echo "  curl:   $(curl --version | head -1)"
echo "  git:    $(git --version)"
echo "  python: $(python3 --version)"
echo "  jq:     $(jq --version)"
```

Save and exit: `Ctrl + O`, `Enter`, `Ctrl + X`.

---

#### Part 4 — Make the Script Executable and Run It

Before you can run a script, you need to give it execute permission:

```bash
chmod +x ~/voh-cloud-prog/session-02E/scripts/voh-setup.sh
```

`chmod` changes file permissions. `+x` adds the execute permission. You will learn permissions in depth in Phase 2.

Run the script:
```bash
bash ~/voh-cloud-prog/session-02E/scripts/voh-setup.sh
```

Read the output carefully. You should see each directory being checked and tools being installed.

If you see any errors, read the error message, identify which line caused it, fix it in nano, and run it again.

---

#### Part 5 — Verify the Tools Were Installed

After the script runs, confirm each tool is available:

```bash
which curl
which wget
which git
which tree
which htop
```

Each should print a path like `/usr/bin/curl`. If any print nothing, the tool was not installed, re-run the script or install it manually:

```bash
sudo apt install -y curl
```


#### Part 6 — Add the bin Directory to PATH

You created a `~/voh-cloud-prog/bin/` directory for your own scripts. Add it to your PATH so you can run scripts from there by name.

Open `.bashrc`:
```bash
nano ~/.bashrc
```

Find your VOH Academy section and add this line inside it:

```bash
export PATH="$HOME/voh-cloud-prog/bin:$PATH"
```

Save and reload:
```bash
source ~/.bashrc
```

Verify it worked:
```bash
echo $PATH | tr ':' '\n' | head -5
```

The first entry should now be your `bin` directory.

Copy your setup script into `bin/` and rename it so it is easy to call:
```bash
cp ~/voh-cloud-prog/session-02E/scripts/voh-setup.sh ~/voh-cloud-prog/bin/voh-setup
chmod +x ~/voh-cloud-prog/bin/voh-setup
```

Now test running it by name from anywhere:
```bash
cd /tmp
voh-setup
```

It should run from `/tmp` because the shell finds it in your `bin/` directory via PATH.

---

#### Part 7 — Write Your Session Report

Create a report documenting what you did in this session. This is a habit you will keep for the entire program — writing up what you built and what you learned.

```bash
nano ~/voh-cloud-prog/session-02E/session-report.md
```

Write the following, filling in your own answers:

```markdown
# Session 06 Report
Date: [today's date]

## What I Built
[Describe the workspace structure you created]

## What the Script Does
[Explain in plain English what voh-setup.sh does, step by step]

## Commands I Used
[List the main commands from this session with a one-line explanation of each]

## What I Found Difficult
[Be honest — what took the longest to understand or get working?]

## What I Would Do Differently
[If you were doing this again, what would you change?]

## One Thing I Want to Learn More About
[Pick one concept from Phase 1 that you want to dig deeper into]
```

Save and exit.

---

### Phase 1 Final Checkpoint

You have completed Phase 1. Before moving to Phase 2, confirm you can do all of the following without notes:

- [ ] Open a terminal and navigate to any directory using absolute and relative paths
- [ ] Create a directory structure with a single `mkdir -p` command
- [ ] Create, read, edit, copy, move, and delete files from the terminal
- [ ] Open and edit a file with both `nano` and `vim`
- [ ] Set an environment variable and read it back
- [ ] Read and understand what the PATH variable does
- [ ] Create an alias and add it to `.bashrc`
- [ ] Write a basic shell script with a loop and conditional logic
- [ ] Make a script executable and run it
- [ ] Use `grep` to search inside files
- [ ] Use `find` to locate files by name

If you are unsure about any of these, go back to the relevant session before continuing.

---

### Optional Certification Milestone

You now have the foundation to attempt the **LPI Linux Essentials (LE-1)** certification. It is designed for beginners and covers exactly what you have learned in Phase 1.

- Exam overview: https://www.lpi.org/our-certifications/linux-essentials-overview
- Free study guide: https://learning.lpi.org/en/learning-materials/010-160
- Cost: approximately $120 USD. It is optional — job-readiness is the goal of this program, but a certification is useful proof of your skills.

---

### Free Resources

| Resource | Link | What it covers |
|---|---|---|
| LPI Linux Essentials study guide | https://learning.lpi.org/en/learning-materials/010-160 | Free official study guide |
| Shell scripting tutorial | https://www.shellscript.sh | Free bash scripting from basics |
| Linux Journey | https://linuxjourney.com | All Phase 1 topics in one place |
| The Linux command line (free book) | https://linuxcommand.org/tlcl.php | Chapters 1–6 cover Phase 1 |
| OverTheWire Bandit | https://overthewire.org/wargames/bandit | Fun Linux command line challenge game |

---

### What Is Coming Next

**Phase 2: Linux Core** begins in Session 07. You will go deep into the fundamentals that make Linux different from every other OS — users, permissions, processes, and the tools that real sysadmins and cloud engineers use every day.

---

*VOH Academy — Zero to Cloud Architect | Phase 1: Foundation*


