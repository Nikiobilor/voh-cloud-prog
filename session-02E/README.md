# VOH Academy — Phase 1: Foundation
## Session 06: Phase 1 Capstone — Build Your Local Engineering Environment

---

### Watch Before You Start
> **YouTube:** [VOH Academy — Session 06: Phase 1 Capstone](https://www.youtube.com/@VOHAcademy)
> Watch the video first, then return here to do the lab.

---

### The VOH Story So Far

End of your first week at VOH. Your manager calls a brief review:

> *"You have made it through the foundation week. You know how the file system works, you can edit config files, you understand your shell. Now we are going to test all of it at once. Your task is to set up a local engineering environment from scratch — the same way every new engineer at VOH gets their machine ready on day one. You will also write your first shell script to automate part of the setup. When you are done, you will have a working local environment and a script you can run on any new machine to recreate it."*

This session has no new concepts. It is entirely a practical lab that tests everything from Sessions 01–05.

---

### What You Will Build

By the end of this session you will have:

1. A clean, organised workspace structure under `~/voh-academy/`
2. A fully configured `.bashrc` with your aliases and variables
3. A working `setup.sh` script that automates the environment setup
4. A `session-06-report.md` file documenting what you did and what you learned

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
ls -la ~/voh-academy/
```

Check your `.bashrc` is set up from Session 05:
```bash
cat ~/.bashrc | grep -A 30 "VOH Academy"
```

If your `.bashrc` customisations from Session 05 are missing, go back and complete Session 05 before continuing.

---

#### Part 2 — Build the Full Workspace Structure

Your final workspace should look like this:

```
~/voh-academy/
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
mkdir -p ~/voh-academy/labs/phase-01
mkdir -p ~/voh-academy/labs/phase-02
mkdir -p ~/voh-academy/labs/phase-03
mkdir -p ~/voh-academy/notes
mkdir -p ~/voh-academy/bin
```

The `bin/` folder is where you will put your own scripts so you can run them by name from anywhere.

Verify the full structure:
```bash
find ~/voh-academy -type d | sort
```

---

#### Part 3 — Write Your First Shell Script

You are going to write a script called `voh-setup.sh` that automates the workspace setup. This means: running the script on a fresh machine should reproduce your entire workspace.

Create the script:
```bash
nano ~/voh-academy/scripts/voh-setup.sh
```

Type this out in full. Read every line as you type it:

```bash
#!/bin/bash
# ============================================================
# VOH Academy — Local Environment Setup Script
# Description: Sets up the standard VOH Academy workspace
# Author: Your Name
# Date: $(date +%Y-%m-%d)
# ============================================================

set -e

# Colours for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}VOH Academy — Environment Setup${NC}"
echo "================================="

# Create workspace directories
echo "Creating workspace structure..."

DIRS=(
    "$HOME/voh-academy/projects/voh-infra/configs"
    "$HOME/voh-academy/projects/voh-infra/logs"
    "$HOME/voh-academy/projects/voh-infra/scripts"
    "$HOME/voh-academy/projects/voh-infra/docs"
    "$HOME/voh-academy/labs/phase-01"
    "$HOME/voh-academy/labs/phase-02"
    "$HOME/voh-academy/labs/phase-03"
    "$HOME/voh-academy/notes"
    "$HOME/voh-academy/bin"
)

for dir in "${DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo "  Created: $dir"
    else
        echo "  Already exists: $dir"
    fi
done

echo -e "${GREEN}Workspace structure ready.${NC}"

# Update package list
echo ""
echo "Updating package list..."
sudo apt update -qq
echo -e "${GREEN}Package list updated.${NC}"

# Install useful tools
echo ""
echo "Installing tools..."
sudo apt install -y -qq \
    curl \
    wget \
    git \
    tree \
    htop \
    unzip

echo -e "${GREEN}Tools installed.${NC}"

# Summary
echo ""
echo "================================="
echo -e "${GREEN}Setup complete.${NC}"
echo "Your VOH Academy workspace is ready at: $HOME/voh-academy"
echo ""
echo "Run 'tree ~/voh-academy' to see the full structure."
```

Save and exit: `Ctrl + O`, `Enter`, `Ctrl + X`.

---

#### Part 4 — Make the Script Executable and Run It

Before you can run a script, you need to give it execute permission:

```bash
chmod +x ~/voh-academy/scripts/voh-setup.sh
```

`chmod` changes file permissions. `+x` adds the execute permission. You will learn permissions in depth in Phase 2.

Run the script:
```bash
bash ~/voh-academy/scripts/voh-setup.sh
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

Each should print a path like `/usr/bin/curl`. If any print nothing, the tool was not installed — re-run the script or install it manually:

```bash
sudo apt install -y curl
```

Use `tree` to see your full workspace structure visually:
```bash
tree ~/voh-academy
```

If tree is installed, you will see a clean visual tree of all your directories and files.

---

#### Part 6 — Add the bin Directory to PATH

You created a `~/voh-academy/bin/` directory for your own scripts. Add it to your PATH so you can run scripts from there by name.

Open `.bashrc`:
```bash
nano ~/.bashrc
```

Find your VOH Academy section and add this line inside it:

```bash
export PATH="$HOME/voh-academy/bin:$PATH"
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
cp ~/voh-academy/scripts/voh-setup.sh ~/voh-academy/bin/voh-setup
chmod +x ~/voh-academy/bin/voh-setup
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
nano ~/voh-academy/notes/session-06-report.md
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
