# VOH Academy — Phase 2: Linux Core
## Session 09: Package Management — apt, Sources, and Software Versions

---

### Watch Before You Start
> **YouTube:** [VOH Academy — Session 09: Package Management](https://www.youtube.com/@VOHAcademy)
> Watch the video first, then return here to do the lab.

---

### The VOH Story So Far

> *"We are standardising our dev servers. Every engineer needs to be able to install, remove, upgrade, and audit software confidently — and know where packages actually come from. We also need someone to investigate why one of our servers has an outdated version of a tool that is causing compatibility issues. That is your ticket today."*

---

### What You Will Learn

- What a package manager is and why Linux uses one
- How `apt` works under the hood (and what `apt-get` is)
- Where packages come from — repositories and sources
- How to install, remove, upgrade, and search for packages
- How to check installed versions and hold packages at a specific version
- How to install software that is not available via `apt` (manual installs, `.deb` files)
- How to clean up unused packages

---

### Concepts

#### What Is a Package Manager?

On Windows, installing software usually means downloading an `.exe` file from a website, running it, and hoping it does not contain anything malicious. There is no central system tracking what is installed or making sure it's compatible with everything else.

Linux does this differently. A **package manager** is a tool that:

- Downloads software from trusted, centrally maintained repositories
- Tracks every dependency a piece of software needs and installs those too
- Lets you update everything with one command
- Lets you cleanly remove software, including its dependencies
- Verifies packages are not tampered with using cryptographic signatures

Ubuntu uses **APT** (Advanced Package Tool). You already used it in Session 02 and Session 06 without knowing the details — now you will understand what is actually happening.

#### apt vs apt-get vs dpkg

There are three layers here:

| Tool | What it is |
|---|---|
| `dpkg` | The lowest-level tool. Installs individual `.deb` package files directly. |
| `apt-get` | The older, scriptable package manager. Still works everywhere. |
| `apt` | The newer, friendlier front-end. What you should use day to day. |

`apt` is built on top of `apt-get`, which is built on top of `dpkg`. As a cloud engineer, you will mostly use `apt`, occasionally `dpkg` for manual `.deb` installs, and you will see `apt-get` in older scripts and documentation.

#### Repositories

A **repository** (or "repo") is a server that hosts packages. Your system has a list of repositories it trusts, stored in `/etc/apt/sources.list` and `/etc/apt/sources.list.d/`.

When you run `apt update`, your system contacts every repository in that list and downloads an updated catalogue of what is available — it does not install anything yet, it just refreshes the list.

When you run `apt install`, it looks through that catalogue, finds the package, and downloads it from the repository.

---

### Lab

```bash
voh
cd projects/voh-infra
```

---

#### Part 1 — Look at Your Sources

View your repository sources:
```bash
cat /etc/apt/sources.list
```

Check for additional source files:
```bash
ls /etc/apt/sources.list.d/
```

These files tell `apt` where to look for packages. Every line follows roughly this format:
```
deb http://archive.ubuntu.com/ubuntu/ focal main restricted
```

`deb` (binary packages), the repository URL, the Ubuntu release codename, and which "components" (main, restricted, universe, multiverse) to include.

---

#### Part 2 — Update and Upgrade, Properly Understood

Refresh the package catalogue:
```bash
sudo apt update
```

See what is available to upgrade without actually installing anything yet:
```bash
apt list --upgradable
```

Now actually upgrade:
```bash
sudo apt upgrade -y
```

The difference between `upgrade` and `dist-upgrade` (rarely needed, but know it exists): `upgrade` will not remove existing packages to satisfy a new dependency. `dist-upgrade` (or `full-upgrade`) will, if necessary, for major version jumps.

---

#### Part 3 — Search, Install, and Inspect Packages

Search for a package before installing it:
```bash
apt search "json"
```

This searches package names and descriptions. The output can be long — pipe it through `less`:
```bash
apt search "json" | less
```

Press `q` to quit.

Get detailed information about a specific package before installing:
```bash
apt show jq
```

This tells you the version, size, dependencies, and a description — without installing anything.

Now install it:
```bash
sudo apt install -y jq
```

`jq` is a tool for working with JSON data from the command line — you will use it extensively once you start working with AWS CLI output in Phase 4.

Confirm it installed and check its version:
```bash
jq --version
```

---

#### Part 4 — List and Search Installed Packages

List every package installed on your system:
```bash
apt list --installed
```

This is a long list. Search within it for something specific:
```bash
apt list --installed | grep nginx
```

Check if a specific package is installed:
```bash
dpkg -l | grep curl
```

Find out which package a specific command came from:
```bash
dpkg -S $(which curl)
```

---

#### Part 5 — Remove and Purge Packages

Install something you will remove for practice:
```bash
sudo apt install -y cowsay
```

Test it:
```bash
cowsay "Hello from VOH Academy"
```

Remove it, keeping its configuration files:
```bash
sudo apt remove -y cowsay
```

Remove it completely, including configuration files (purge):
```bash
sudo apt purge -y cowsay
```

The difference matters: `remove` is for when you might reinstall later and want to keep your settings. `purge` is a full clean removal.

---

#### Part 6 — Clean Up Unused Packages

Over time, dependencies that are no longer needed by anything pile up. Clean them out:

```bash
sudo apt autoremove -y
```

Clear out the local cache of downloaded `.deb` files (frees disk space, does not affect installed software):
```bash
sudo apt autoclean
```

Or remove the entire download cache:
```bash
sudo apt clean
```

---

#### Part 7 — Hold a Package at a Specific Version (the Real Ticket)

This is the actual problem from this session's ticket. Sometimes you need a tool to **not** auto-upgrade, because a newer version breaks compatibility with something else.

First check the current version of a package:
```bash
apt-cache policy jq
```

This shows the installed version and the candidate version available from the repository.

To prevent a package from being upgraded, you put a "hold" on it:
```bash
sudo apt-mark hold jq
```

Confirm the hold:
```bash
apt-mark showhold
```

Now even if you run `apt upgrade`, `jq` will be skipped and a note will appear telling you it was held back.

Remove the hold when you are ready to allow upgrades again:
```bash
sudo apt-mark unhold jq
```

---

#### Part 8 — Installing Software Outside apt (Manual .deb Install)

Not everything is in Ubuntu's default repositories. Sometimes you download a `.deb` file directly from a vendor's website and install it manually.

Download a real example — the GitHub CLI tool's official `.deb` package (you will use this tool in Phase 3):

```bash
curl -L -o /tmp/gh.deb https://github.com/cli/cli/releases/download/v2.55.0/gh_2.55.0_linux_amd64.deb
```

Install the downloaded `.deb` file directly with `dpkg`:
```bash
sudo dpkg -i /tmp/gh.deb
```

If you see dependency errors, fix them with:
```bash
sudo apt --fix-broken install
```

Then confirm it installed:
```bash
gh --version
```

This is the pattern you will use anytime official `apt` repositories do not have the latest version of a tool.

**Note:** if this exact version URL is outdated by the time you do this lab, visit https://github.com/cli/cli/releases to find the current `.deb` download link and substitute it above.

---

#### Part 9 — Document the Investigation

```bash
nano ~/voh-academy/projects/voh-infra/docs/ticket-009-package-audit.md
```

Write:

```markdown
# Ticket VOH-009: Package Version Audit

## Request
Investigate outdated tool causing compatibility issues. Establish version control practices for packages going forward.

## Investigation Commands Used
- apt-cache policy <package>   — check installed vs available version
- apt list --installed | grep <name>  — confirm what's on the system
- dpkg -l | grep <name>        — alternate way to check installed packages

## Resolution
Used apt-mark hold to lock a package at a known-working version.
Documented the held package so future engineers know why it is not auto-upgrading.

## VOH Standard Going Forward
- Always check apt-cache policy before reporting a "wrong version" bug
- Use apt-mark hold for packages where a newer version breaks compatibility
- Document every held package with a reason and review date
- Prefer apt over manual dpkg installs unless the package is not in the repos
```

Save and exit.

---

### Checkpoint

Before moving on, confirm you can do all of the following:

- [ ] Explain the relationship between `dpkg`, `apt-get`, and `apt`
- [ ] Explain what a repository is and where your system's list of repos lives
- [ ] Search for a package and view its details before installing
- [ ] Install, remove, and purge a package
- [ ] List installed packages and search within that list
- [ ] Find which package provides a given command
- [ ] Clean up unused dependencies and cached files
- [ ] Hold a package at its current version and later release the hold
- [ ] Manually install a `.deb` file with `dpkg`

---

### Free Resources

| Resource | Link | What it covers |
|---|---|---|
| Ubuntu — Package Management | https://ubuntu.com/server/docs/package-management | Official documentation |
| DigitalOcean — apt essentials | https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg | Free, practical guide |
| jq manual | https://jqlang.org/manual | jq reference, useful for later phases |

---

### What Is Coming Next

Session 10: Networking basics — IP addresses, DNS, ports, and how to diagnose connectivity problems from the command line.

---

*VOH Academy — Zero to Cloud Architect | Phase 2: Linux Core*
