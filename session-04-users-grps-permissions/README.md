# VOH Academy — Phase 2: Linux Core
## Session 04: Users, Groups, and Permissions

---

### Watch Before You Start
> **YouTube:** [VOH Academy — Session 04: Users, Groups, and Permissions]https://youtu.be/mK9_-39xYnE
> Watch the video first, then return here to do the lab.

---

### The VOH Story So Far

You have finished your first week. Monday morning, a new ticket appears in your queue from the VOH security team:

> *"We are onboarding two new engineers, Tamara and David. We need separate user accounts created for them on the dev server, with the correct access level. We also found a config file last week that had the wrong permissions and any user on the box could read it, that cannot happen again. Set up the accounts, get the permissions right, and document what you did."*

This is one of the most common real tasks a junior cloud or sysadmin engineer does. Get this right and you will never fear a permissions error again.

---

### What You Will Learn

- What users and groups are in Linux, and why they exist
- The difference between root and a regular user
- How to read and interpret permission strings (`rwxr-xr-x`)
- How to change permissions with `chmod` (symbolic and numeric)
- How to change ownership with `chown` and `chgrp`
- How to create users and groups
- Special permissions: sudo and the sudoers file

---

### Concepts

#### Users and Groups

Every Linux system tracks **who** is allowed to do **what**. Two ideas make this work:

- **Users** — individual accounts. Every process and file is owned by a user.
- **Groups** — collections of users. You assign permissions to a group once, and every user in that group gets that access.

At VOH, every engineer gets an individual user account — never a shared login. This means every action on a server can be traced back to a specific person. This matters enormously for security and accountability.

#### root: The Superuser

`root` is the all-powerful account on any Linux system. It can read, write, and execute anything, bypass all permission checks, and change any setting.

Because root is so powerful, **you never log in directly as root** in professional environments. Instead, you log in as your own user and use `sudo` to temporarily run a single command as root — with a record kept of exactly what you did.

#### Reading Permissions

Run `ls -l` on any file and you will see something like this:

```
-rwxr-xr-- 1 nwachi devteam 1024 Jun 24 09:00 deploy.sh
```

Break this down:

```
-rwxr-xr--
│└┬┘└┬┘└┬┘
│ │  │  └── others: r-- (read only)
│ │  └───── group:  r-x (read and execute)
│ └──────── owner:  rwx (read, write, execute)
└────────── file type: - (regular file), d (directory), l (symlink)
```

Each permission set has three positions:
- `r` = read (4)
- `w` = write (2)
- `x` = execute (1)

A `-` means that permission is not granted.

#### Numeric (Octal) Permissions

Each `rwx` combination has a numeric value, because `r=4`, `w=2`, `x=1`, and you add them together:

| Combination | Value |
|---|---|
| `rwx` | 7 (4+2+1) |
| `rw-` | 6 (4+2) |
| `r-x` | 5 (4+1) |
| `r--` | 4 |
| `---` | 0 |

So `rwxr-xr--` becomes `754` — owner has 7, group has 5, others have 4.

This is the format you will use most often with `chmod`.

---

### Lab

```bash
voh
cd projects/voh-infra
```

(Recall: `voh` is your alias from Session 02 that jumps to `~/voh-cloud-prog`)

---

#### Part 1 — Inspect Permissions

List files with permission details:
```bash
ls -l configs/
```

List with hidden files and human-readable sizes:
```bash
ls -lah configs/
```

Check the permissions of your home directory:
```bash
ls -ld ~
```

The `-d` flag shows information about the directory itself, not its contents.

Check who you are and what groups you belong to:
```bash
whoami
groups
id
```

`id` shows your user ID (UID), group ID (GID), and all group memberships at once.

---

#### Part 2 — Create the Permissions Test Environment

Create a working folder for this lab:

```bash
mkdir -p ~/voh-cloud-prog/projects/voh-infra/permissions-lab
cd ~/voh-cloud-prog/projects/voh-infra/permissions-lab
```

Create a few test files:
```bash
touch deploy.sh app.conf secrets.env public-notice.txt
ls -l
```

Notice the default permissions — typically `rw-r--r--` (644) for files created with `touch`.

---

#### Part 3 — Change Permissions with chmod (Symbolic Mode)

Make `deploy.sh` executable for the owner only:
```bash
chmod u+x deploy.sh
ls -l deploy.sh
```

`u+x` means "add execute permission for the user (owner)."

Other symbolic combinations:

| Symbol | Meaning |
|---|---|
| `u` | user (owner) |
| `g` | group |
| `o` | others |
| `a` | all (user, group, and others) |
| `+` | add a permission |
| `-` | remove a permission |
| `=` | set exactly (overwrite) |

Remove read access from others on `secrets.env`:
```bash
chmod o-r secrets.env
ls -l secrets.env
```

Give the group write access on `app.conf`:
```bash
chmod g+w app.conf
ls -l app.conf
```

Set exact permissions on `public-notice.txt` — readable by everyone, writable by nobody:
```bash
chmod a=r public-notice.txt
ls -l public-notice.txt
```

---

#### Part 4 — Change Permissions with chmod (Numeric Mode)

Numeric mode is faster once you are comfortable with it. Set `deploy.sh` to be fully usable by the owner only (rwx for owner, nothing for anyone else):

```bash
chmod 700 deploy.sh
ls -l deploy.sh
```

Set `secrets.env` so only the owner can read and write it — no execute, no access for anyone else:
```bash
chmod 600 secrets.env
ls -l secrets.env
```

This `600` permission is the standard for sensitive files like SSH private keys and credential files. Remember this — you will use it constantly when working with AWS credentials and SSH keys.

Set `app.conf` to a typical config file permission — owner read/write, group read-only, others nothing:
```bash
chmod 640 app.conf
ls -l app.conf
```

Set `public-notice.txt` to standard public readable:
```bash
chmod 644 public-notice.txt
ls -l public-notice.txt
```

---

#### Part 5 — Directory Permissions Work Differently

Create a test directory:
```bash
mkdir restricted-folder
touch restricted-folder/secret-file.txt
```

Remove execute permission from the directory for owner:
```bash
chmod u-x restricted-folder
```

Try to access a file inside it as a regular operation:
```bash
ls restricted-folder/
```

Restore it:
```bash
chmod u+x restricted-folder
```

---

#### Part 6 — Ownership with chown and chgrp

Check current ownership:
```bash
ls -l deploy.sh
```

You will see your username as both the owner and the group (typically, on a single-user WSL setup, your group matches your username).

Changing ownership normally requires `sudo` because it affects system-level metadata. Try it on a file you own:

```bash
sudo chown $USER:$USER deploy.sh
```

This sets the owner and group both to your own username, explicitly. It will look unchanged because it already was, but you have now practiced the syntax.

The general syntax:
```bash
sudo chown newowner:newgroup filename
sudo chown newowner filename          # owner only
sudo chgrp newgroup filename          # group only
```

---

#### Part 7 — Create Users and Groups (Simulating VOH's Onboarding Ticket)

Now you will complete the actual ticket from the start of this session: create accounts for Tamara and David.

Create a group for the dev team:
```bash
sudo groupadd voh-devteam
```

Confirm it was created:
```bash
cat /etc/group | grep voh-devteam
```

Create a user account for Tamara:
```bash
sudo useradd -m -G voh-devteam -s /bin/bash tamara
```

Breaking this down:
- `-m` — create a home directory for her (`/home/tamara`)
- `-G voh-devteam` — add her to the voh-devteam group
- `-s /bin/bash` — set her default shell to bash

Set a password for her account:
```bash
sudo passwd tamara
```

You will be prompted to type a password twice. Use something simple for this lab, like `VohAcademy2026!`

Repeat for David:
```bash
sudo useradd -m -G voh-devteam -s /bin/bash david
sudo passwd david
```

Confirm both accounts exist:
```bash
cat /etc/passwd | grep -E "tamara|david"
```

Confirm both are in the dev team group:
```bash
getent group voh-devteam
groups david
groups tamara
```

---

#### Part 8 — Set Up Shared Group Access (the Real Ticket Requirement)

VOH wants Tamara and David to share access to a project folder without giving them root.

Create a shared folder:
```bash
sudo mkdir -p /opt/voh-shared
```

Set its group ownership to voh-devteam:
```bash
sudo chgrp voh-devteam /opt/voh-shared
```

Set permissions so the group can read, write, and enter the folder, but others cannot:
```bash
sudo chmod 770 /opt/voh-shared
```

Verify:
```bash
ls -ld /opt/voh-shared
```

You should see something like `drwxrwx--- ... voh-devteam`.

This means: Tamara and David (both in voh-devteam) can fully use this folder. Nobody outside the group can touch it. This is exactly how real teams share access on a server without using root.

---

#### Part 9 — sudo and the sudoers File

Check if your own user has sudo access:
```bash
sudo -l
```

This lists the commands your user is allowed to run with sudo. On a fresh WSL install, your user usually has full sudo access.

**Never edit `/etc/sudoers` directly with nano or vim** — a syntax error in this file can break sudo access entirely, even for root. Always use the safe editor built for this purpose:

```bash
sudo visudo
```

This opens the sudoers file with built-in syntax checking. For this lab, just open it to look — do not change anything. Exit without saving:

If it opens in nano-style: `Ctrl + X`, then `N` if asked to save.
If it opens in vim-style: `:q!`

---

#### Part 10 — Document the Ticket

Create a record of what you did, the way you would for a real VOH support ticket:

```bash
nano ~/voh-cloud-prog/projects/voh-infra/docs/ticket-004-user-onboarding.md
```

Write:

```markdown
# Ticket VOH-004: New Engineer Onboarding

## Request
Create user accounts for Tamara and David with appropriate group access.
Secure a previously over-permissioned config file.

## Actions Taken
1. Created group: voh-devteam
2. Created user: tamara (home dir, bash shell, added to voh-devteam)
3. Created user: david (home dir, bash shell, added to voh-devteam)
4. Created shared folder /opt/voh-shared owned by voh-devteam group, permissions 770
5. Reviewed permission model for sensitive files (600 for secrets, 640 for configs)

## Verification
- Confirmed both users exist in /etc/passwd
- Confirmed both users are members of voh-devteam via getent group
- Confirmed /opt/voh-shared permissions restrict access to group members only

## Notes
Permissions follow VOH standard:
- 600 — sensitive files (credentials, keys)
- 640 — config files (owner write, group read)
- 644 — public/shared documentation
- 770 — shared team directories
```

Save and exit.

---

### Checkpoint

Before moving on, confirm you can do all of the following:

- [ ] Read a permission string like `rwxr-xr--` and explain each character
- [ ] Convert a symbolic permission to its numeric equivalent
- [ ] Use `chmod` in both symbolic and numeric mode
- [ ] Explain why `x` on a directory means something different than `x` on a file
- [ ] Change file ownership with `chown` and group ownership with `chgrp`
- [ ] Create a new group with `groupadd`
- [ ] Create a new user with `useradd`, with a home directory and a specific shell
- [ ] Set up a shared directory with correct group permissions
- [ ] Explain why you should never edit `/etc/sudoers` directly

---

### Free Resources

| Resource | Link | What it covers |
|---|---|---|
| Linux Journey — Permissions | https://linuxjourney.com/lesson/file-permissions-introduction | Interactive permissions lessons |
| chmod calculator | https://chmod-calculator.com | Visual permission calculator |
| Ubuntu — Users and Groups | https://ubuntu.com/server/docs/security-users | Official Ubuntu documentation |

---

### What Is Coming Next

Session 08: Processes and services — how to see what is running on a Linux system, how to stop and start services, and how systemd manages everything in the background.

---

*VOH Academy — Zero to Cloud Architect | Phase 2: Linux Core*
