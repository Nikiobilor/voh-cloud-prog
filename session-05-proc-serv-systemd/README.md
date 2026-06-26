# VOH Academy — Phase 2: Linux Core
## Session 05: Processes, Services, and systemd

---

### Watch Before You Start
> **YouTube:** [VOH Academy — Session 05: Processes and Services](https://www.youtube.com/@VOHAcademy)
> Watch the video first, then return here to do the lab.

---

### The VOH Story So Far

A new alert lands in the team channel:

> *"One of our test servers is running slow and we don't know why. Before we can fix anything in production, every engineer needs to know how to look at a running system and answer: what is running, how much resource is it using, and how do I stop or restart something safely. Today's ticket: investigate a slow server, identify the problem process, and write up what you found."*

---

### What You Will Learn

- What a process is and how Linux tracks running programs
- How to view running processes with `ps` and `top`
- How to stop processes safely with `kill`
- The difference between a process and a service
- How `systemd` manages services that run in the background
- How to start, stop, enable, and check the status of a service
- How to read service logs with `journalctl`

---

### Concepts

#### What Is a Process?

Every time you run a program — `ls`, `nano`, a web server, a Python script — Linux creates a **process** to run it. Each process gets:

- A unique **PID** (Process ID)
- A **parent process** (the process that started it — its PPID)
- Its own memory space
- A status (running, sleeping, stopped, zombie)


#### Foreground vs Background Processes

A **foreground** process holds your terminal hostage until it finishes — you cannot type anything else until it is done.

A **background** process runs without blocking your terminal. You add `&` to the end of a command to send it to the background.

#### Services and systemd

A **service** is a process designed to run continuously in the background, usually starting automatically when the machine boots — things like a web server, a database, or an SSH server.

Modern Ubuntu uses **systemd** to manage services. systemd starts services in the right order at boot, restarts them if they crash, and gives you one consistent tool — `systemctl` — to control all of them.

---

### Lab

```bash
voh
cd projects/voh-infra
```

---

#### Part 1 — View Running Processes

See your own processes:
```bash
ps
```

See every process running on the system, in full detail:
```bash
ps aux
```

Breaking down the columns: `USER` (who owns it), `PID` (process ID), `%CPU` and `%MEM` (resource usage), `STAT` (status), `COMMAND` (what is running).

See processes in a live, auto-refreshing view:
```bash
top
```

Inside `top`: press `P` to sort by CPU usage, `M` to sort by memory usage, `q` to quit.

A more modern, readable alternative :
```bash
htop
```

Inside `htop`: use arrow keys to scroll, `F9` to send a signal to a process, `F10` or `q` to quit.

---

#### Part 2 — Find a Specific Process

Search for a process by name:
```bash
ps aux | grep bash
```

Get the PID of your current shell:
```bash
echo $$
```

---

#### Part 3 — Foreground and Background Processes

Run a command that takes time, in the foreground:
```bash
sleep 30
```

Your terminal is now frozen for 30 seconds. Wait it out, or press `Ctrl + C` to cancel early.

Now run it in the background:
```bash
sleep 60 &
```

Notice your terminal immediately gives you back control. The shell prints a job number and PID, like `[1] 12345`.

See your background jobs:
```bash
jobs
```

Bring a background job back to the foreground:
```bash
fg %1
```

Press `Ctrl + C` to stop it, or let it run to completion.

Send a running foreground process to the background: start a process, then press `Ctrl + Z` to pause it, then run `bg` to resume it in the background.

```bash
sleep 60
```
Press `Ctrl + Z`, then:
```bash
bg
jobs
```

---

#### Part 4 — Stop a Process with kill

Start a background process to practice on:
```bash
sleep 300 &
```

Note its PID from the output, or find it:
```bash
pgrep sleep
```

Stop it gracefully (this sends the default signal, `SIGTERM`, asking the process to shut down cleanly):
```bash
kill <PID>
```

Replace `<PID>` with the actual number.

Confirm it stopped:
```bash
jobs
```

If a process refuses to stop with a normal `kill`, force it with `SIGKILL`:
```bash
sleep 300 &
kill -9 <PID>
```

`-9` is forceful — it does not let the process clean up after itself. Use it only when a normal `kill` does not work.

Kill a process by name instead of PID:
```bash
sleep 300 &
pkill sleep
```

---

#### Part 5 — Install and Run a Real Service: nginx

You will now install a real web server and manage it as a systemd service — exactly as you would on a VOH server.

Install nginx:
```bash
sudo apt update
sudo apt install -y nginx
```

Check its status:
```bash
sudo systemctl status nginx
```

Read the output carefully — it tells you whether it is active, when it started, its PID, and recent log lines.

Press `q` to exit the status view if it drops you into a pager.

---

#### Part 6 — Control the Service

Stop the service:
```bash
sudo systemctl stop nginx
sudo systemctl status nginx
```

Notice the status now shows "inactive (dead)."

Start it again:
```bash
sudo systemctl start nginx
sudo systemctl status nginx
```

Restart it (stop then start in one command — useful after a config change):
```bash
sudo systemctl restart nginx
```

Reload it (re-reads config without fully stopping the service — less disruptive, used in production):
```bash
sudo systemctl reload nginx
```

---

#### Part 7 — Enable a Service to Start on Boot

Check if nginx is set to start automatically when the machine boots:
```bash
sudo systemctl is-enabled nginx
```

Enable it to start automatically:
```bash
sudo systemctl enable nginx
```

Disable it from starting automatically (it will still run now, but won't auto-start on boot):
```bash
sudo systemctl disable nginx
```

**Note for WSL users:** systemd support in WSL depends on your WSL version and configuration. If `systemctl` commands give an error about systemd not running, this is a known WSL limitation — note it in your report and continue; you will manage real systemd services on actual AWS EC2 instances starting in Phase 4.

---

#### Part 8 — Verify nginx Is Actually Working

Check what port nginx is listening on:
```bash
sudo ss -tulnp | grep nginx
```

`ss` shows network socket information. `-t` (TCP), `-u` (UDP), `-l` (listening ports), `-n` (ports numeric), `-p` (show the process).

Test it directly with curl:
```bash
curl http://localhost
```

You should see HTML output — the default nginx welcome page.

---

#### Part 9 — Read Service Logs with journalctl

View the full log for nginx:
```bash
sudo journalctl -u nginx
```

View only the most recent 20 lines:
```bash
sudo journalctl -u nginx -n 20
```

Follow the log live (like `tail -f`) — open a second terminal, run this, then in your first terminal restart nginx and watch the log update in real time:
```bash
sudo journalctl -u nginx -f
```

Press `Ctrl + C` to stop following.

View logs from the last hour:
```bash
sudo journalctl -u nginx --since "1 hour ago"
```

---

#### Part 10 — Investigate and Document (the Actual Ticket)

Simulate the "slow server" investigation from this session's ticket. Run this to see the top 5 processes by memory usage:

```bash
ps aux --sort=-%mem | head -6
```

And by CPU usage:
```bash
ps aux --sort=-%cpu | head -6
```

Document your findings:

```bash
nano ~/voh-academy/projects/voh-infra/docs/ticket-005-process-investigation.md
```

Write:

```markdown
# Ticket VOH-005: Process Investigation

## Request
Investigate a slow server and identify resource usage.

## Investigation Steps
1. Checked top processes by memory: ps aux --sort=-%mem
2. Checked top processes by CPU: ps aux --sort=-%cpu
3. Installed and tested nginx as a working service example
4. Verified nginx status, logs, and listening port

## Findings
[Write what processes were using the most resources on your system]

## Service Management Commands Used
- systemctl status/start/stop/restart/reload/enable/disable
- journalctl -u <service> for logs
- ss -tulnp to check listening ports

## Notes
A process is a running instance of a program with a PID.
A service is a process managed by systemd to run continuously in the background.
kill sends SIGTERM (graceful); kill -9 sends SIGKILL (forceful, last resort).
```

Save and exit.

---

### Checkpoint

Before moving on, confirm you can do all of the following:

- [ ] List running processes with `ps aux` and explain the key columns
- [ ] Use `top` or `htop` to view live system resource usage
- [ ] Run a command in the background with `&` and bring it to the foreground with `fg`
- [ ] Stop a process with `kill` and explain the difference between `kill` and `kill -9`
- [ ] Explain the difference between a process and a service
- [ ] Start, stop, restart, and reload a systemd service
- [ ] Check whether a service is enabled to start on boot
- [ ] Read service logs with `journalctl`
- [ ] Check which port a service is listening on with `ss`

---

### Free Resources

| Resource | Link | What it covers |
|---|---|---|
| Linux Journey — Processes | https://linuxjourney.com/lesson/what-is-a-process | Process fundamentals |
| DigitalOcean — systemd essentials | https://www.digitalocean.com/community/tutorials/systemd-essentials-working-with-services-units-and-the-journal | Free, thorough systemd guide |
| journalctl manual | https://man7.org/linux/man-pages/man1/journalctl.1.html | Full reference |

---

### What Is Coming Next

Session 09: Package management in depth — how `apt` actually works, installing software from different sources, and managing software versions safely.

---

*VOH Academy — Zero to Cloud Architect | Phase 2: Linux Core*
