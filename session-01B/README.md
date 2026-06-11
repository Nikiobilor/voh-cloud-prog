# VOH Academy — Phase 1: Foundation
## Session 01B: Installing WSL and Opening Your First Terminal

---

### The VOH Story So Far

Your manager reviewed your Session 01A notes and replied:

> *"Good. You understand the basics. Now it is time to actually get your hands on Linux. We run Ubuntu on all our servers. Your local machine runs Windows, so we are going to install WSL — Windows Subsystem for Linux. This gives you a real Linux environment right inside your Windows machine. Follow the steps below and send me a screenshot of your terminal when you are done."*

---

### What You Will Learn

- What WSL is and why it exists
- How to install WSL and Ubuntu on Windows
- How to open a Linux terminal
- How to run your very first Linux commands
- How to navigate between Windows and WSL

---

### Requirements

- A Windows 10 (version 2004 or later) or Windows 11 machine
- An internet connection
- At least 2GB of free disk space
- Administrator access to your machine (you can install software)

To check your Windows version: press `Windows key + R`, type `winver`, press Enter.

---

### Concepts

#### What Is WSL?

WSL stands for Windows Subsystem for Linux. It is a feature built into Windows that lets you run a full Linux operating system inside your Windows machine — without rebooting, without a virtual machine, without any complex setup.

When you open WSL, you get a Linux terminal. You can run Linux commands, install Linux tools, and do everything a Linux engineer does — all while staying on your Windows desktop.

At VOH, developers use WSL to work locally before pushing changes to real Linux servers on AWS. It is the standard way cloud engineers on Windows machines work.

#### What Is Ubuntu?

Ubuntu is a version of Linux. There are many versions of Linux (called distributions or "distros") — Ubuntu, Debian, Fedora, Arch, and others. They all share the same core but differ in how they look and what tools they include by default.

Ubuntu is the most widely used Linux distro for servers and for learning. It is what AWS EC2 instances run at VOH. So that is what you will use here.

---

### Lab

#### Step 1 — Enable WSL

Open PowerShell as Administrator.

To do this: click the Start menu, type `PowerShell`, right-click on **Windows PowerShell**, and select **Run as administrator**.

Run this command:

```powershell
wsl --install
```

This command:
- Enables the WSL feature in Windows
- Downloads and installs Ubuntu automatically
- Sets WSL 2 as the default version

You will see progress output as it downloads. This may take several minutes depending on your internet speed.

When it finishes, **restart your computer**.

---

#### Step 2 — Set Up Your Ubuntu User

After restarting, Ubuntu will open automatically and continue setting up. If it does not open automatically, click the Start menu and open **Ubuntu**.

You will see:

```
Installing, this may take a few minutes...
Please create a default UNIX user account. The username does not need to match your Windows username.
Enter new UNIX username:
```

Choose a username. Use only lowercase letters and no spaces. For example: `nwachi` or `vohuser`.

Then set a password. **Note:** when you type a password in Linux, nothing appears on screen — not even dots. This is normal. Type your password and press Enter.

Type it again to confirm.

You will then see a prompt like this:

```
nwachi@DESKTOP-ABC123:~$
```

You are now inside a Linux terminal. This is your working environment for the rest of this program.

---

#### Step 3 — Update Your System

The first thing you always do on a fresh Linux install is update the package list and upgrade installed packages. Run these two commands one at a time:

```bash
sudo apt update
```

```bash
sudo apt upgrade -y
```

**What is happening here:**
- `sudo` — run the command as an administrator (called "superuser" in Linux)
- `apt` — the package manager for Ubuntu (like an app store, but for the terminal)
- `update` — refresh the list of available packages
- `upgrade -y` — install all available updates, automatically say yes to prompts

You will see a lot of text scroll by. That is normal. Wait for it to finish.

---

#### Step 4 — Run Your First Commands

Try each of these commands. After each one, read what it outputs and make sure you understand it.

**Who are you?**
```bash
whoami
```
This prints your username. It answers the question: who is currently logged in?

**Where are you?**
```bash
pwd
```
This prints your current location in the file system. `pwd` stands for "print working directory." You should see something like `/home/nwachi`.

**What is here?**
```bash
ls
```
This lists the files and folders in your current location. Your home directory is empty for now — that is fine.

**What machine is this?**
```bash
uname -a
```
This prints information about your operating system. You will see "Linux" in the output, confirming you are running a real Linux kernel.

**How much disk space do you have?**
```bash
df -h
```
This shows disk usage. The `-h` flag means "human readable" — it shows sizes in GB and MB instead of raw numbers.

---

#### Step 5 — Find Your WSL Files from Windows

Your WSL home directory is accessible from Windows Explorer.

Open Windows Explorer and type this in the address bar:

```
\\wsl$\Ubuntu\home\
```

You will see your Linux home folder. You can drag files between Windows and WSL using this path.

Alternatively, from inside your WSL terminal, you can access your Windows files at:

```bash
ls /mnt/c/Users/
```

This shows the contents of your Windows C drive. Your Windows home folder is at `/mnt/c/Users/YourWindowsUsername/`.

---

#### Step 6 — Create Your VOH Academy Workspace

Inside your WSL terminal, create a dedicated folder for all your VOH Academy work:

```bash
mkdir -p ~/voh-cloud-prog
```

Then move into it:

```bash
cd ~/voh-cloud-prog
```

Then confirm where you are:

```bash
pwd
```

You should see: `/home/yourusername/voh-cloud-prog`

This folder is your workspace for the entire program.

---

### Checkpoint

Before moving to Session 03, confirm you can do all of the following:

- [ ] Open the Ubuntu terminal from the Windows Start menu
- [ ] Run `whoami` and see your username
- [ ] Run `pwd` and see your home directory path
- [ ] Run `ls` without errors
- [ ] See your `voh-cloud-prog` folder when you run `ls ~`

If any of these do not work, go back through the steps above before continuing.

---

### Troubleshooting

**WSL install says "feature not supported"**
Your Windows version may be too old. Run `winver` and confirm you are on Windows 10 version 2004 (build 19041) or later. If not, run Windows Update first.

**I forgot my Linux password**
Open PowerShell as Administrator and run:
```powershell
wsl -u root
```
Then run:
```bash
passwd yourusername
```
Replace `yourusername` with the username you chose.

**`sudo apt upgrade` asks me questions during upgrade**
If you see a prompt asking about configuration files, press `Enter` to accept the default. If you see a blue screen asking about restarting services, press Tab to highlight `OK` and press Enter.

**My terminal shows weird characters or colours**
This is a font issue. Open Ubuntu, click the title bar icon, go to Properties, and change the font to **Cascadia Code** or **Consolas**.

---

### Free Resources

| Resource | Link | What it covers |
|---|---|---|
| Microsoft WSL official docs | https://learn.microsoft.com/en-us/windows/wsl/install | Official install guide |
| Ubuntu documentation | https://help.ubuntu.com | Official Ubuntu help |
| The Linux command line (free book) | https://linuxcommand.org/tlcl.php | Full free book on the Linux CLI |

---

### What Is Coming Next

Session 03: The Linux file system — how files and folders are organised, how to create and move things, and why everything in Linux is a file.

---

*VOH Academy — Zero to Cloud Architect | Phase 1: Foundation*
