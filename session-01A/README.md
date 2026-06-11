# VOH Academy — Phase 1: Foundation
## Session 01: How Computers Work (and Why It Matters for the Cloud)
---

### The VOH Story So Far

You just got hired at **VOH** — a cloud infrastructure company building systems for businesses across Africa and beyond.

Your manager sends you a Slack message on your first day:

> *"Welcome to the team. Before we give you access to any of our servers, we need to know you understand what a server actually is. Complete Session 01 and show me your notes."*

This session has no commands to run. It is all about building the mental model you will need for everything that comes after.

---

### What You Will Learn

- What a computer actually is (CPU, RAM, storage, network)
- The difference between hardware and software
- What an operating system does
- Why Linux runs most of the world's servers
- What "the cloud" actually means in plain terms

---

### Concepts

#### 1. The Four Parts of Every Computer

Every computer — your laptop, a phone, a server in a data centre — is built from the same four things:

| Part | What it does | Real world analogy |
|---|---|---|
| **CPU** (processor) | Runs instructions | The brain |
| **RAM** (memory) | Holds data being used right now | Your desk |
| **Storage** (disk) | Holds data long-term | A filing cabinet |
| **Network** (NIC) | Sends and receives data | A telephone |

When you run a program, the CPU reads instructions from storage into RAM and executes them. The faster the CPU and the more RAM you have, the more the computer can do at once.

#### 2. Hardware vs Software

**Hardware** is the physical machine — the chips, the cables, the screen.

**Software** is the instructions that tell the hardware what to do. Software lives on storage and runs in RAM.

There are two kinds of software:
- **System software** — manages the hardware (e.g. the operating system)
- **Application software** — does things for users (e.g. a browser, a text editor)

#### 3. What an Operating System Does

The operating system (OS) sits between you and the hardware. It:

- Manages the CPU (decides which program runs when)
- Manages memory (gives programs the RAM they need)
- Manages storage (organises files on disk)
- Manages the network (sends and receives data)
- Provides a way for you to interact with the machine (a shell or a GUI)

Without an OS, you would have to talk to the hardware directly — in binary. The OS makes the machine usable.

#### 4. Why Linux?

There are three major operating systems: Windows, macOS, and Linux.

Windows and macOS are closed — companies own and control them. Linux is open source — anyone can read the code, use it, modify it, and distribute it. For free.

Because of this:
- Linux runs on over 90% of the world's servers
- Linux runs on Android phones
- Linux runs in cloud data centres (AWS, Azure, GCP all run Linux underneath)
- Linux is free — no licence cost

When you work in the cloud, you are almost always working on a Linux machine. That is why this entire program is built on Linux.

#### 5. What Is "the Cloud"?

The cloud is not magic. It is just someone else's computers.

A company like AWS (Amazon Web Services) owns millions of physical servers sitting in data centres around the world. They rent access to those servers over the internet. When a business says it "runs in the cloud," it means its software is running on those rented servers instead of servers the business owns itself.

The benefits:
- You only pay for what you use
- You can scale up or down instantly
- You do not have to manage the physical hardware

As a cloud architect, your job is to design how those rented computers are connected and configured to make a business work.

---

### Knowledge Check

Answer these in your own words in a text file called `session-01-notes.txt`. There are no right or wrong answers, this is to test your own understanding.

1. If you close a program on your computer, what happens to the data it was holding in RAM?
2. Why do you think cloud companies like AWS use Linux instead of Windows on their servers?
3. In your own words, describe the cloud to someone who has never heard of it.
4. What is the difference between RAM and storage?
5. VOH runs its infrastructure on AWS. Based on what you now know, what does that actually mean?

---

### How to Submit Your Notes

For now, you are just keeping notes for yourself. In Session 03 you will learn Git and will start tracking your work properly.

Create a folder on your Windows desktop called `voh-cloud-prog`. Inside it, create a text file called `session-01-notes.txt` and write your answers there.

---

### Free Resources

These are all free. Use them to go deeper on anything from this session.

| Resource | Link | What it covers |
|---|---|---|
| CS50 Introduction to Computer Science | https://cs50.harvard.edu/x | Broad CS fundamentals, free |
| Linux Foundation — Introduction to Linux | https://training.linuxfoundation.org/training/introduction-to-linux | Free Linux intro course |
| AWS Cloud Practitioner Essentials | https://explore.skillbuilder.aws/learn/course/134 | Free on AWS Skill Builder |
| What is the cloud? (AWS explainer) | https://aws.amazon.com/what-is-cloud-computing | Short official explainer |

---

### What Is Coming Next

Session 02: You will install WSL (Windows Subsystem for Linux) on your machine and open a real Linux terminal for the first time.

---

*VOH Academy — Zero to Cloud Architect | Phase 1: Foundation*
