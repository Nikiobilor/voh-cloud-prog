# VOH Academy — Phase 1: Foundation
## Session: Your Shell — Environment Variables, PATH, and Aliases

---

### Watch Before You Start
> **YouTube:** [VOH Academy: Shell Basics and Environment Variables](https://youtu.be/6rOyGhLgtS8)
> Watch the video first, then return here to do the lab.

---

### The VOH Story So Far

A senior engineer at VOH pulls you aside before standup:

> *"I noticed you are typing full paths every time you run a command. Let me show you how the shell actually works, once you understand environment variables and the PATH, you will stop doing that. You will also set up aliases so your most common commands take half the keystrokes. This is how we all work here."*

---

### What You Will Learn

- What a shell is and what bash is
- What environment variables are and how to use them
- How the PATH works, how Linux finds commands
- How to create aliases for commands you use often
- How to make your customisations permanent using `.bashrc`

---

### Concepts

#### What Is a Shell?

A shell is a program that takes your commands and passes them to the operating system to execute. When you type `ls` and press Enter, the shell reads that, finds the `ls` program, and runs it.

The shell you are using is called **bash** (Bourne Again Shell). It is the default on Ubuntu and on most Linux servers.

There are other shells — `zsh`, `fish`, `sh` — but bash is what you will find on almost every server you work on at VOH. Learn bash.

#### What Are Environment Variables?

Environment variables are named values that the shell keeps in memory. They hold information about the system and your session, things like who you are, where your home directory is, what language your system uses, and where to find programs.

Every program you run can read these variables. They are the way the shell and programs share context with each other.

#### How the PATH Works

When you type `ls`, how does Linux know where the `ls` program is? It checks a special environment variable called `PATH`.

`PATH` is a list of directories separated by `:`. Linux looks through each one in order until it finds a program with the name you typed.

```
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

When you install a new program, it gets placed in one of these directories. That is why you can run it by name without typing its full path.

---

### Lab

Open your WSL terminal:

```bash
cd ~/voh-cloud-prog
```

---

#### Part 1 — Explore Your Shell Environment

Print the name of your current shell:
```bash
echo $SHELL
```

Print all environment variables currently set:
```bash
env
```

This will print a lot. Scroll through it and find a few familiar ones.

Print specific variables:
```bash
echo $HOME
echo $USER
echo $PATH
echo $PWD
```

`HOME` — your home directory
`USER` — your username
`PATH` — the list of directories Linux searches for programs
`PWD` — your current directory (same as `pwd`)


---

#### Part 2 — Set Your Own Environment Variables

Set a temporary environment variable:
```bash
export VOH_ENV=development
```

Read it back:
```bash
echo $VOH_ENV
```

This variable exists only in your current terminal session. If you open a new terminal, it will be gone.

Set a few more that you will use throughout the program:
```bash
export VOH_PROJECT=voh-infra
export VOH_DIR=~/voh-cloud-prog/projects/voh-infra
```

Test them:
```bash
echo $VOH_PROJECT
ls $VOH_DIR
```

Notice that `ls $VOH_DIR` works — the shell expands the variable before running the command.

---

#### Part 3 — Understand Which Command Runs

When you type a command, use `which` to see exactly which file the shell is running:

```bash
which bash
which nano
which python3
```

Use `type` for more detail:
```bash
type cd
type echo
```

Notice that `cd` and `echo` are "shell builtins" — they are built into bash itself, not separate programs on disk.

---

#### Part 4 — Create Aliases

An alias is a shortcut — a short name that expands to a longer command.

Create a temporary alias:
```bash
alias ll='ls -lah'
```

Test it:
```bash
ll
```

`ls -lah` shows files in a long list format (`-l`), includes hidden files (`-a`), and shows sizes in human-readable format (`-h`).

Create more aliases:
```bash
alias voh='cd ~/voh-cloud-prog'
alias configs='cd ~/voh-cloud-prog/projects/voh-infra/configs'
alias docs='cd ~/voh-cloud-prog/projects/voh-infra/docs'
```

Test them:
```bash
cd /tmp
voh
configs
```

You should be back in `~/voh-cloud-prog`.

List all your current aliases:
```bash
alias
```

Remove an alias:
```bash
unalias docs
```

---

#### Part 5 — Make It Permanent with .bashrc

Everything you have set above disappears when you close the terminal. To make it permanent, you add it to `.bashrc`.

`.bashrc` is a hidden file in your home directory that bash reads every time it starts. Put your customisations there and they will always be available.

Open it with nano:
```bash
nano ~/.bashrc
```

Scroll to the very bottom of the file (use `Ctrl + End` or keep pressing the down arrow).

Add this block at the end. Type it out carefully:

```bash
# ============================================================
# VOH Academy — Custom Shell Configuration
# ============================================================

# Environment variables
export VOH_ENV=development
export VOH_PROJECT=voh-infra
export VOH_DIR=~/voh-cloud-prog/projects/voh-infra

# Navigation aliases
alias ll='ls -lah'
alias la='ls -A'
alias voh='cd ~/voh-cloud-prog'
alias configs='cd ~/voh-cloud-prog/projects/voh-infra/configs'
alias scripts='cd ~/voh-cloud-prog/projects/voh-infra/scripts'
alias docs='cd ~/voh-cloud-prog/projects/voh-infra/docs'

# Safety aliases (ask before overwriting)
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Useful shortcuts
alias cls='clear'
alias h='history'
alias ports='ss -tulnp'
```

Save and exit: `Ctrl + O`, `Enter`, `Ctrl + X`.

Now reload `.bashrc` so the changes take effect immediately (without opening a new terminal):
```bash
source ~/.bashrc
```

Test that everything loaded:
```bash
echo $VOH_ENV
ll
voh
```

---

#### Part 6 — Command History

The shell keeps a record of every command you have run.

View your history:
```bash
history
```

Search your history for a specific command:
```bash
history | grep mkdir
```

Run a command from history by its number (replace 42 with an actual number from your history):
```bash
!42
```

---

#### Part 7 — Check Your Shell Session

See how long your shell has been running and what processes are active:
```bash
ps
```
yes > /dev/null &
sleep 3
ps

kill %1

See all running processes:
```bash
ps aux | head -20
```

---

### Checkpoint

Before moving on, confirm you can do all of the following:

- [ ] Print an environment variable with `echo $VARNAME`
- [ ] Set a new environment variable with `export`
- [ ] Read the PATH and understand what it does
- [ ] Create an alias and use it
- [ ] Add aliases and variables to `.bashrc`
- [ ] Reload `.bashrc` with `source`
- [ ] Search command history with `Ctrl + R`

---

### Free Resources

| Resource | Link | What it covers |
|---|---|---|
| Bash manual | https://www.gnu.org/software/bash/manual | Full bash reference |
| Linux Journey — Command Line | https://linuxjourney.com/lesson/the-shell | Shell fundamentals |
| Bash scripting cheatsheet | https://devhints.io/bash | Quick bash reference |

---

### What Is Coming Next

Session 06: Phase 1 Capstone — you will put everything together by setting up a complete local development environment that mirrors how VOH engineers work. You will also write your first shell script.

---

*VOH Academy — Zero to Cloud Architect | Phase 1: Foundation*


