# 🚀 VOH Academy — Cloud Engineering Journal

> **A ticket-driven, lab-first, production-simulated engineering training program.**
> This repository documents a 12-week journey from complete beginner to job-ready Cloud Engineer.

---

## 🎯 What This Repository Is

This is not a tutorial notes repo. This is an **engineering operations portfolio** — every folder represents a real production-style ticket, investigated, deployed, troubleshot, validated, and documented as a junior engineer on the VOH Platform Engineering team.

Each ticket simulates the kind of work done daily inside:
- ☁️ Cloud Support teams
- ⚙️ DevOps teams
- 🏗️ Platform Engineering teams
- 🔧 Infrastructure Operations teams

---

## 🗺️ Program Overview

| | Details |
|---|---|
| **Duration** | 12 Weeks |
| **Total Tickets** | 60 production-style engineering tickets |
| **Target Roles** | Cloud Support Engineer · DevOps Engineer · Platform Engineer |
| **Cloud Platform** | AWS Free Tier |
| **Local Environment** | WSL2 Ubuntu 22.04 on Windows |
| **Starting Level** | Complete beginner — no prior tech background |
| **End Goal** | Job-ready, portfolio-proven cloud engineer |

---

## 📁 Repository Structure

```
voh-engineering-journal/
│
├── week01/          # Linux Foundation & Workstation Setup
├── week02/          # Networking Foundations & Cloud Infrastructure
├── week03/          # Infrastructure as Code — Terraform
├── week04/          # Configuration Management — Ansible
├── week05/          # Containers & Kubernetes
├── week06/          # CI/CD Pipelines — GitHub Actions & Jenkins
├── week07/          # Observability — Prometheus, Grafana & Loki
├── week08/          # GitOps — ArgoCD & Helm
├── week09/          # Security Engineering
├── week10/          # Python Automation & Scripting
├── week11/          # Production Incidents & SRE Practices
├── week12/          # Capstone Project — Full Production Deployment
│
├── dotfiles/        # My shell configuration (.bashrc, aliases)
├── CONTRIBUTING.md  # Git branching workflow & commit standards
└── README.md        # You are here
```

---

## 📋 Weekly Breakdown

### ✅ Week 1 — Linux Foundation & Workstation Setup
| Ticket | Title | Key Skills |
|--------|-------|------------|
| VOH-W01-T01 | Bootstrap WSL2 Ubuntu Workstation | WSL2, SSH, Git, GitHub CLI |
| VOH-W01-T02 | Linux CLI Proficiency & System Administration | Bash, permissions, processes, scripting |
| VOH-W01-T03 | Git Branching, Merge Conflicts & PR Workflow | Git, GitHub, branching strategy |
| VOH-W01-T04 | AWS Account Hardening — IAM Security Baseline | IAM, MFA, CloudTrail, billing alerts |
| VOH-W01-T05 | Docker Containerisation & GHCR Registry Push | Docker, Dockerfile, Docker Compose, GHCR |

### 🔄 Week 2 — Networking Foundations & Cloud Infrastructure
*(In progress)*

### 🔜 Weeks 3–12 — Coming as program progresses

---

## 🛠️ Tools & Technologies

**Operating System & Shell**
`Ubuntu 22.04` `WSL2` `Bash` `Zsh`

**Version Control**
`Git` `GitHub` `GitHub CLI` `GitHub Actions`

**Cloud**
`AWS Free Tier` `IAM` `VPC` `EC2` `S3` `Route 53` `CloudTrail` `CloudWatch`

**Infrastructure as Code**
`Terraform / OpenTofu` `Ansible`

**Containers & Orchestration**
`Docker` `Docker Compose` `Kubernetes (k3s/kind)` `Helm` `ArgoCD`

**CI/CD**
`GitHub Actions` `Jenkins`

**Observability**
`Prometheus` `Grafana` `Loki`

**Security**
`Trivy` `Falco` `kube-bench` `Vault`

**Networking**
`Nginx` `HAProxy` `Cloudflare (Free Tier)`

**Languages**
`Python` `Bash`

---

## 📐 How Each Ticket Is Structured

Every ticket folder contains:

```
weekXX/
└── T0X-ticket-name/
    ├── README.md          # Full walkthrough, commands, troubleshooting
    ├── scripts/           # Bash or Python scripts produced
    ├── configs/           # Config files (nginx, ansible, terraform, etc.)
    ├── screenshots/       # Validation evidence
    └── architecture/      # Diagram of what was built
```

Each `README.md` includes:
- 📖 Scenario context & business impact
- 🎯 Technical objectives
- 💻 Step-by-step commands with explanations
- ✅ Validation procedures
- 🔥 Troubleshooting guide (what broke and how I fixed it)
- 🔒 Security notes
- 💡 Lessons learned

---

## 🏆 Capstone Project (Week 12)

A full production-style deployment bringing together every skill from the 12 weeks:

- Multi-tier AWS infrastructure provisioned with **Terraform**
- Application configuration managed with **Ansible**
- Containerised workloads running on **Kubernetes**
- CI/CD pipeline via **GitHub Actions**
- Full observability stack: **Prometheus + Grafana + Loki**
- GitOps delivery via **ArgoCD**
- Security scanning with **Trivy** and **Falco**
- Custom domain with **Cloudflare** + **Route 53** DNS

---

## 📊 My Progress

- [x] Week 1 — Linux Foundation & Workstation Setup
- [ ] Week 2 — Networking Foundations & Cloud Infrastructure
- [ ] Week 3 — Infrastructure as Code (Terraform)
- [ ] Week 4 — Configuration Management (Ansible)
- [ ] Week 5 — Containers & Kubernetes
- [ ] Week 6 — CI/CD Pipelines
- [ ] Week 7 — Observability
- [ ] Week 8 — GitOps
- [ ] Week 9 — Security Engineering
- [ ] Week 10 — Python Automation
- [ ] Week 11 — Production Incidents & SRE
- [ ] Week 12 — Capstone Project

---

## 🤝 Connect

If you're a recruiter, hiring manager, or fellow engineer, feel free to explore the folders, read the ticket READMEs, and see the actual work, not just a CV claim.

Every command in this repo was run, every error was encountered, and every fix was earned.

---

*Built through the VOH Academy Cloud Engineering Talent Hub program.*
# voh-cloud-prog
