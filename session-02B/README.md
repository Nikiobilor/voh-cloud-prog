# VOH Academy — Phase 1: Foundation
## Session 04: Text Editors — Writing Config Files Like an Engineer

---

### Watch Before You Start
> **YouTube:** [VOH Academy — Session 04: Text Editors in the Terminal](https://www.youtube.com/@VOHAcademy)
> Watch the video first, then return here to do the lab.

---

### The VOH Story So Far

Your manager is pleased with your file system work. A new ticket lands in your queue:

> *"We need you to update a config file on one of our test servers. You will not have a desktop GUI — just a terminal. This means you need to know how to edit files directly in the terminal. Learn nano first (it is beginner-friendly), then get comfortable with vim basics (it is what you will find on most production servers). Then write your first real config file using what you have learned."*

---

### What You Will Learn

- How to open, edit, and save files with `nano`
- The basics of `vim` — why it exists and how to not get stuck in it
- How to write a real nginx-style config file by hand
- How to use terminal shortcuts that make editing faster

---

### Concepts

#### Why Not Just Use a GUI Editor?

When you connect to a remote server (like an AWS EC2 instance), you connect over SSH — a terminal connection. There is no desktop, no File Explorer, no right-click. You get a command line and nothing else.

Every cloud engineer needs to edit files from the terminal. It is not optional.

There are two editors you will encounter everywhere:

| Editor | Personality | When you use it |
|---|---|---|
| `nano` | Beginner-friendly. Shows shortcuts at the bottom. | Quick edits, learning, everyday use |
| `vim` | Steep learning curve. Extremely powerful. | Found on almost every Linux server by default |

You will use `nano` for most labs in this program. You will learn enough `vim` to survive when `nano` is not available.

#### How vim Works (the Mental Model)

vim has **modes**. This is what trips up every beginner.

- **Normal mode** — where you start. Keys are commands, not letters. You navigate and run commands here.
- **Insert mode** — where you type text. Press `i` to enter insert mode.
- **Command mode** — where you save and quit. Press `:` from normal mode.

The most important vim commands:

| Key | What it does |
|---|---|
| `i` | Enter insert mode (start typing) |
| `Esc` | Go back to normal mode |
| `:w` | Save (write) the file |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving (force quit) |
| `dd` | Delete the current line (in normal mode) |
| `u` | Undo |

---

### Lab

Open your WSL terminal and move to your workspace:

```bash
cd ~/voh-academy/projects/voh-infra/configs/
```

---

#### Part 1 — Edit a File with nano

Open the server config file you created in Session 03:

```bash
nano voh-server.conf
```

You are now inside nano. You will see the file contents and at the bottom, a list of shortcuts shown as `^X` — the `^` means `Ctrl`.

Use the arrow keys to move your cursor to the end of the file.

Add this content (type it out, do not copy-paste — typing builds muscle memory):

```
# VOH Server Configuration
# Environment: development
# Managed by: VOH Cloud Team

[server]
hostname = voh-dev-01
port = 8080
environment = development

[logging]
level = info
output = /var/log/voh/app.log

[security]
ssh_port = 22
allow_root_login = no
```

Save the file: press `Ctrl + O`, then press `Enter` to confirm the filename.

Exit nano: press `Ctrl + X`.

Confirm the file was saved:
```bash
cat voh-server.conf
```

---

#### Part 2 — nano Shortcuts Practice

Open the file again:
```bash
nano voh-server.conf
```

Practice these shortcuts:

| Shortcut | What it does |
|---|---|
| `Ctrl + O` | Save (write Out) |
| `Ctrl + X` | Exit |
| `Ctrl + K` | Cut the current line |
| `Ctrl + U` | Paste (Uncut) |
| `Ctrl + W` | Search (Where is) |
| `Ctrl + G` | Help |
| `Alt + U` | Undo |

Use `Ctrl + W` to search for the word `security`. nano will jump to that line.

Exit without making changes: `Ctrl + X`. If asked to save, press `N`.

---

#### Part 3 — Survive vim

Create a new file using vim:

```bash
vim vim-test.txt
```

You are in normal mode. Notice nothing you type appears as text.

Enter insert mode:
```
i
```

Type this text:
```
This is my first vim file.
VOH Academy Session 04.
```

Go back to normal mode:
```
Esc
```

Save and quit:
```
:wq
```

Press Enter after typing `:wq`.

Confirm the file exists:
```bash
cat vim-test.txt
```

Now practice the emergency exit. Open the file again:
```bash
vim vim-test.txt
```

Make a change — type `i`, add some text. Then change your mind. Exit without saving:
```
Esc
:q!
```

Confirm the file is unchanged:
```bash
cat vim-test.txt
```

---

#### Part 4 — Write a Real Config File

Your manager has sent you the specification for a new nginx web server configuration file that VOH uses on its test servers. You will write this file from scratch using nano.

Create the file:
```bash
nano ~/voh-academy/projects/voh-infra/configs/nginx-voh.conf
```

Type out this entire configuration. Read each line as you type it — every line means something:

```nginx
# VOH Academy — nginx configuration
# Server: voh-web-01
# Environment: development

server {
    # The port this server listens on
    listen 80;

    # The domain name this server responds to
    server_name voh-dev.local;

    # Where the website files are stored
    root /var/www/voh;

    # The default file to serve
    index index.html;

    # Logging
    access_log /var/log/nginx/voh-access.log;
    error_log  /var/log/nginx/voh-error.log;

    # Handle all requests
    location / {
        try_files $uri $uri/ =404;
    }
}
```

Save and exit: `Ctrl + O`, `Enter`, `Ctrl + X`.

Verify the file:
```bash
cat ~/voh-academy/projects/voh-infra/configs/nginx-voh.conf
```

Count the number of lines in the file:
```bash
wc -l ~/voh-academy/projects/voh-infra/configs/nginx-voh.conf
```

---

#### Part 5 — Search Inside Files

Search for all lines containing the word `log` in your nginx config:

```bash
grep "log" ~/voh-academy/projects/voh-infra/configs/nginx-voh.conf
```

Search case-insensitively:
```bash
grep -i "server" ~/voh-academy/projects/voh-infra/configs/nginx-voh.conf
```

Show line numbers with results:
```bash
grep -n "location" ~/voh-academy/projects/voh-infra/configs/nginx-voh.conf
```

Search across all files in the configs directory:
```bash
grep -r "voh" ~/voh-academy/projects/voh-infra/configs/
```

`grep` is one of the most used tools in a cloud engineer's toolkit. You will use it constantly to search logs and config files.

---

#### Part 6 — Terminal Shortcuts

These shortcuts work in any terminal and will save you hours over time. Practice them now:

| Shortcut | What it does |
|---|---|
| `Ctrl + C` | Stop the current command |
| `Ctrl + L` | Clear the screen |
| `Ctrl + A` | Jump to start of line |
| `Ctrl + E` | Jump to end of line |
| `Ctrl + U` | Delete from cursor to start of line |
| `Up arrow` | Recall previous command |
| `Tab` | Auto-complete a filename or command |
| `!!` | Repeat the last command |
| `!$` | Use the last argument of the previous command |

Practice tab completion:
```bash
cat ~/voh-academy/projects/voh-infra/configs/ngi
```
Press `Tab` and it should complete to `nginx-voh.conf`.

---

### Checkpoint

Before moving on, confirm you can do all of the following:

- [ ] Open a file with nano, make changes, save, and exit
- [ ] Open a file with vim, enter insert mode, type text, return to normal mode, and save and quit
- [ ] Exit vim without saving using `:q!`
- [ ] Use grep to search for text inside a file
- [ ] Use grep to search across multiple files with `-r`
- [ ] Use tab completion to finish a long filename

---

### Free Resources

| Resource | Link | What it covers |
|---|---|---|
| nano documentation | https://www.nano-editor.org/docs.php | Full nano reference |
| Open vim tutorial (in browser) | https://www.openvim.com | Interactive vim tutorial, free |
| vim adventures (game) | https://vim-adventures.com | Learn vim by playing a game (first levels free) |
| grep manual | https://www.gnu.org/software/grep/manual | Full grep documentation |

---

### What Is Coming Next

Session 05: Understanding your terminal — shell basics, environment variables, the PATH, aliases, and how to customise your shell to work the way you want.

---

*VOH Academy — Zero to Cloud Architect | Phase 1: Foundation*
