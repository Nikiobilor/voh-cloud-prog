# VOH Academy — Phase 1: Foundation
## Session 02A: The Linux File System — Everything Is a File

---

### Watch Before You Start
> **YouTube:** [VOH Academy — Session 02A: The Linux File System](https://youtu.be/j5-lbOXK2ic)
> Watch the video first, then return here to do the lab.

---

### The VOH Story So Far

You have your terminal. Your manager sends a new message:

> *"Before we let you near any of our servers, you need to understand how Linux organises files. On Windows, you have C:\\ and D:\\. On Linux, it works completely differently. Read the briefing below, then complete the lab. You will be creating and organising files exactly the way our sysadmins do when they set up a new server."*

---

### What You Will Learn

- How the Linux file system is structured (the directory tree)
- What the most important system directories are and what they do
- How to create, rename, move, copy, and delete files and folders
- How to read and write to files from the terminal
- How to find files on the system

---

### Concepts

#### The Linux Directory Tree

On Windows, files live on drives: `C:\Users\Name\Documents\file.txt`

On Linux, everything lives under one root: `/home/name/documents/file.txt`

There is no C drive or D drive. There is only `/` — called "root" — and everything branches from there.

```
/
├── bin        — essential command binaries (ls, cp, mv)
├── etc        — system configuration files
├── home       — home directories for users (/home/nwachi)
├── var        — variable data (logs, databases)
├── tmp        — temporary files (cleared on reboot)
├── usr        — user programs and utilities
├── opt        — optional/third party software
├── root       — home directory for the root user (admin)
└── mnt        — mount points (where external drives/WSL Windows files appear)
```

As a cloud engineer, you will spend most of your time in:
- `/home/yourusername` — your personal workspace
- `/etc` — reading and editing config files
- `/var/log` — reading logs to debug problems
- `/opt` — installing and running custom software

#### Paths: Absolute vs Relative

An **absolute path** starts from root `/` and gives the full location:
```
/home/nwachi/voh-cloud-prog/notes.txt
```

A **relative path** starts from wherever you currently are:
```
voh-cloud-prog/notes.txt        (if you are in /home/nwachi)
../voh-cloud-prog/notes.txt     (.. means "go up one level")
```

The `~` symbol is a shortcut for your home directory:
```
~/voh-cloud-prog/notes.txt  =  /home/nwachi/voh-cloud-prog/notes.txt
```

---

### Lab

Open your WSL terminal and move into your workspace:

```bash
cd ~/voh-cloud-prog
```

---

#### Part 1 — Explore the System

First, look around the Linux file system to understand what is there.

Look at the root directory:
```bash
ls /
```

Look at your home directory:
```bash
ls ~
```

Look at the system config directory (you are not changing anything, just looking):
```bash
ls /etc
```

Look at the system log directory:
```bash
ls /var/log
```

Now check where you are:
```bash
pwd
```

---

#### Part 2 — Create the VOH Project Structure

Your manager has asked you to create a standard folder structure that VOH uses when setting up a new project. Follow the specification below exactly.

Create this structure inside `~/voh-cloud-prog/`:

```
~/voh-cloud-prog/
└── projects/
    └── voh-infra/
        ├── configs/
        ├── logs/
        ├── scripts/
        └── docs/
```

Create the top level:
```bash
mkdir -p ~/voh-cloud-prog/session-02A/projects/voh-infra/configs
mkdir -p ~/voh-cloud-prog/session-02A/projects/voh-infra/logs
mkdir -p ~/voh-cloud-prog/session-02A/projects/voh-infra/scripts
mkdir -p ~/voh-cloud-prog/session-02A/projects/voh-infra/docs
```

The `-p` flag tells `mkdir` to create all parent directories along the path if they do not already exist.

Confirm the structure was created:
```bash
ls ~/voh-cloud-prog/session-02A/projects/voh-infra/
```

You should see: `configs  docs  logs  scripts`

---

#### Part 3 — Create and Write Files

Create a project readme file inside `docs/`:

```bash
touch ~/voh-cloud-prog/session-02A/projects/voh-infra/docs/README.md
```

`touch` creates an empty file. If the file already exists, it updates the timestamp.

Now write content into the file using `echo`:

```bash
echo "# VOH Infrastructure Project" > ~/voh-cloud-prog/session-02A/projects/voh-infra/docs/README.md
```

The `>` symbol redirects the output of `echo` into the file, replacing its contents.

Add a second line using `>>` (which appends instead of replacing):

```bash
echo "Managed by the VOH Cloud Team." >> ~/voh-cloud-prog/session-02A/projects/voh-infra/docs/README.md
echo "Created: $(date)" >> ~/voh-cloud-prog/session-02A/projects/voh-infra/docs/README.md
```

`$(date)` runs the `date` command and puts its output inline. This is called command substitution.

Read the file back:
```bash
cat ~/voh-cloud-prog/session-02A/projects/voh-infra/docs/README.md
```

You should see all three lines.

---

#### Part 4 — Copy, Move, and Rename

Create a draft config file:

```bash
echo "# Server config draft" > ~/voh-cloud-prog/session-02A/projects/voh-infra/configs/server.conf.draft
```

Copy it to create a final version:
```bash
cp ~/voh-cloud-prog/session-02A/projects/voh-infra/configs/server.conf.draft \
   ~/voh-cloud-prog/session-02A/projects/voh-infra/configs/server.conf
```

Confirm both files exist:
```bash
ls ~/voh-cloud-prog/session-02A/projects/voh-infra/configs/
```

Now move the draft to the logs folder (as an archive):
```bash
mv ~/voh-cloud-prog/session-02A/projects/voh-infra/configs/server.conf.draft \
   ~/voh-cloud-prog/session-02A/projects/voh-infra/logs/server.conf.draft.bak
```

Confirm the move:
```bash
ls ~/voh-cloud-prog/session-02A/projects/voh-infra/configs/
ls ~/voh-cloud-prog/session-02A/projects/voh-infra/logs/
```

`mv` also renames files. Rename the final config:
```bash
mv ~/voh-cloud-prog/session-02A/projects/voh-infra/configs/server.conf \
   ~/voh-cloud-prog/session-02A/projects/voh-infra/configs/voh-server.conf
```

---

#### Part 5 — Read Files in Different Ways

Create a longer file to practice reading:

```bash
cat > ~/voh-cloud-prog/session-02A/projects/voh-infra/docs/notes.txt << 'EOF'
Session 03 Notes
=================
The Linux file system starts at /.
Everything is a file in Linux.
Configuration files live in /etc.
Logs live in /var/log.
My workspace is in ~/voh-cloud-prog.
The cat command reads files.
The less command reads files one page at a time.
EOF
```

Read the whole file at once:
```bash
cat ~/voh-cloud-prog/session-02A/projects/voh-infra/docs/notes.txt
```

Read it one page at a time (useful for long files):
```bash
less ~/voh-cloud-prog/session-02A/projects/voh-infra/docs/notes.txt
```

Inside `less`: press `Space` to go forward, `b` to go back, `q` to quit.

Read only the first 3 lines:
```bash
head -3 ~/voh-cloud-prog/session-02A/projects/voh-infra/docs/notes.txt
```

Read only the last 3 lines:
```bash
tail -3 ~/voh-cloud-prog/session-02A/projects/voh-infra/docs/notes.txt
```

---

#### Part 6 — Find Files

Find all `.md` files inside your voh-cloud-prog folder:

```bash
find ~/voh-cloud-prog -name "*.md"
```

Find all files modified in the last 10 minutes:
```bash
find ~/voh-cloud-prog -mmin -10
```

Find a file by partial name:
```bash
find ~/voh-cloud-prog -name "*server*"
```

---

#### Part 7 — Delete Safely

Delete the backup file you created:
```bash
rm ~/voh-cloud-prog/session-02A/projects/voh-infra/logs/server.conf.draft.bak
```

Confirm it is gone:
```bash
ls ~/voh-cloud-prog/session-02A/projects/voh-infra/logs/
```

**Important:** Linux has no recycle bin. When you `rm` a file, it is gone. Always double-check before deleting. Use `ls` to confirm the path before you run `rm`.

To delete a folder and everything inside it:
```bash
rm -r /path/to/folder
```

**Never run `rm -rf /` — this deletes the entire file system.**

---

### Checkpoint

Before moving on, confirm you can do all of the following without looking at the steps:

- [ ] Navigate to any directory using absolute and relative paths
- [ ] Create a nested directory structure with one `mkdir -p` command
- [ ] Create a file with `touch` and write to it with `echo`
- [ ] Append to a file without overwriting it
- [ ] Read a file with `cat`, `head`, `tail`, and `less`
- [ ] Copy a file with `cp`
- [ ] Move and rename a file with `mv`
- [ ] Delete a file with `rm`
- [ ] Find files by name with `find`

---

### Free Resources

| Resource | Link | What it covers |
|---|---|---|
| The Linux command line (free book) | https://linuxcommand.org/tlcl.php | Chapters 3–4 cover this session |
| Linux Journey | https://linuxjourney.com | Interactive free Linux lessons |
| ExplainShell | https://explainshell.com | Paste any command to see what each part does |

---

### What Is Coming Next

Session 04: Text editors in the terminal, how to open, edit, and save files using `nano` and an introduction to `vim`. You will also write your first real configuration file.

---

*VOH Academy — Zero to Cloud Architect | Phase 1: Foundation*
