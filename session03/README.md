VOH-W01-T03  ·  Git Version Control Operations — Branch Strategy, Merge Conflicts & PR Workflow

Week 1  ·  Day 3  ·  Linux Foundation & Workstation Setup

##🏢 Business Scenario##
The VOH engineering team has adopted a Git branching strategy (GitFlow-lite) for all infrastructure code. A team member pushed directly to main and caused a merge conflict that is blocking the team. You have been assigned a ticket to: resolve the merge conflict, restructure the repository with a proper branching strategy, and document the team's Git workflow.

##💥 Business Impact##
Unresolved merge conflicts block feature deployment. Engineers who do not understand Git workflows cause repeated conflicts, lost work, and deployment failures in CI/CD pipelines.

⏱ SLA Expectation	
Merge conflict resolved within 1 hour. Git workflow documentation delivered by EOD.

🔧 Required Tools	
Git, GitHub, GitHub CLI (gh), Vim (for merge conflict resolution)

⏳ Estimated Duration	3–4 hours

  ● SEVERITY: MEDIUM  

🎯 Technical Objectives
•	Understand and implement a Git branching strategy: main, develop, feature/*, hotfix/*
•	Simulate and resolve a realistic Git merge conflict using the CLI
•	Create Pull Requests (PRs) using GitHub CLI
•	Understand git rebase vs git merge and when to use each
•	Write meaningful commit messages using Conventional Commits format
•	Protect the main branch using GitHub branch protection rules
•	Use git log, git diff, git blame to investigate repository history

📋 Prerequisites
•	Completed VOH-W01-T01 (GitHub SSH access configured)
•	voh-cloud-prog repository exists on GitHub

🔩 Engineering Tasks
21.	Create a develop branch and set it as the integration branch
22.	Create feature/linux-notes branch from develop and add Linux notes
23.	Simultaneously create a conflicting change on main to simulate a real conflict
24.	Attempt to merge feature branch and observe the conflict
25.	Resolve the merge conflict manually using a text editor
26.	Create a Pull Request from feature/linux-notes to develop using gh pr create
27.	Review the PR, approve it, and merge using squash merge
28.	Tag a release using git tag -a v0.1.0 with a semantic version message
29.	Configure branch protection on main: require PR review, no direct pushes
30.	Write a CONTRIBUTING.md documenting the team's Git workflow

💻 Step-by-Step Commands
# === SETUP BRANCHING STRATEGY ===
cd ~/voh-cloud-prog
git checkout -b develop 
git push -u origin develop

# === SIMULATE MERGE CONFLICT ===
# --- Branch 1: Feature branch ---
git checkout -b feature/linux-notes 
echo 'Linux is the foundation of cloud engineering.' > notes.md
git add . && git commit -m 'feat: add linux foundation notes'

# --- Branch 2: Simultaneous change on develop ---
git checkout develop
echo 'Cloud engineering starts with Linux mastery.' > notes.md
git add . && git commit -m 'docs: add cloud engineering notes'

# === TRIGGER THE CONFLICT ===
git checkout feature/linux-notes
git merge develop  # <-- CONFLICT OCCURS HERE

# === RESOLVE THE CONFLICT ===
cat notes.md       # See conflict markers: <<<<<<, =======, >>>>>>>
vim notes.md       # Edit to keep desired content, remove markers
git add notes.md
git commit -m 'fix: resolve merge conflict in notes.md'


# === install github cli === SKIP IF YOU ALREADY HAVE Github cli installed
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt update

sudo apt install gh
gh --version
gh auth login

# === CREATE PULL REQUEST === install github cli with #sudo apt install gitsome
git push -u origin featur
e/linux-notes
gh pr create --base develop --head feature/linux-notes \
  --title 'feat: Linux foundation notes' \
  --body 'Adds Linux foundation notes for Week 1 training'

# === OR ===

switch to the github UI and complete the pull request and merging to main

# === REVIEW AND MERGE ===
gh pr list
gh pr merge --squash  # or use GitHub UI

# === MAIN BRANCH REVIEW ===
git checkout main
ls   # shows the existing content
git diff main..develop
git merge develop
git push origin 

# === INSPECT HISTORY ===
git log --graph --decorate --all
git diff main..develop
git blame notes.md



✅ Validation Steps
•	Run: git log --oneline --graph --all — should show clean history with branches
•	Run: git tag — should show v0.1.0
•	Run: gh pr list — should show PR in merged state
•	Verify: CONTRIBUTING.md exists and documents the branching workflow
•	Verify: notes.md has no conflict markers (<<<, ===, >>>)

🔥 Troubleshooting Scenarios
Problem: git merge shows 'Already up to date' — no conflict triggered
Fix: The conflict requires DIFFERENT changes to the SAME line in the same file on two branches. Ensure both branches modified the same line in notes.md before merging.
Problem: gh pr create fails with 'pull request already exists'
Fix: A PR from this branch to this base already exists. View it: gh pr list. Either close it: gh pr close NUMBER or use the existing PR.
Problem: git push -u origin feature/linux-notes fails: 'remote rejected — protected branch'
Fix: Branch protection is too aggressive or applied to wrong branches. Feature branches should never be protected. Check protection rules: gh api repos/{owner}/{repo}/branches/main/protection
Problem: After resolving conflict, git commit says 'nothing to commit'
Fix: You must git add the resolved files BEFORE committing. Run: git add notes.md then git commit -m 'fix: resolve conflict'. The staging step is mandatory.

📦 Expected Deliverables
•	Git repository with clean branching structure: main, develop, feature/* branches
•	Resolved merge conflict committed with proper message
•	Merged Pull Request visible on GitHub
•	Git tag v0.1.0 pushed to GitHub
•	CONTRIBUTING.md with team Git workflow documented
•	Screenshot of git log --graph showing branch history

🐙 GitHub Deliverables
•	Updated: voh-cloud-prog with branching structure
•	File: CONTRIBUTING.md — Git workflow guide
•	File: notes.md — resolved, clean content
•	Evidence: Merged PR visible in Pull Requests tab

📝 Documentation Requirements
CONTRIBUTING.md must define: branch naming convention, commit message format (Conventional Commits), PR process, review requirements
Document the difference between git merge --ff-only, --no-ff, and --squash
Include a visual ASCII diagram of the branching strategy in the README
Document how to revert a bad commit: git revert vs git reset

🏗 Architecture Diagram Requirement
Draw a GitFlow-lite branching diagram showing: main, develop, feature branches, PR arrows, merge direction, and tag placement. Show the timeline of commits on each branch. Include this as an ASCII diagram in CONTRIBUTING.md.

🎤 Interview Questions
What is the difference between git merge and git rebase? When should you never rebase?
Explain what HEAD, origin, and upstream mean in Git context
What is a squash merge? What are its benefits over a regular merge?
How would you undo the last 3 commits without losing the file changes?
What is git cherry-pick and when would you use it in a production scenario?

⚠️ Common Mistakes to Avoid
Committing directly to main — this bypasses all review and CI/CD checks
Using git push --force on shared branches — this rewrites public history and breaks teammates' work
Writing vague commit messages like 'fix stuff' or 'update' — use Conventional Commits format
Not resolving ALL conflict markers — leaving <<<, ===, >>> in code breaks applications
Creating branches from the wrong base — always branch from develop, not main

🚀 Stretch Goals
•	Set up a git commit-msg hook that enforces Conventional Commits format on every commit
•	Configure git aliases for complex log commands: git config --global alias.lg 'log --oneline --graph --all'
•	Set up GitHub Actions to run a linting check on every PR (even just echo 'PR check passed')
•	Explore git bisect to simulate finding which commit introduced a bug
•	Configure signed commits using GPG: git config --global commit.gpgsign true

🌍 Real-World Engineering Relevance
Git merge conflicts are the #1 daily friction point in engineering teams. At companies like GitLab, Netflix, and Shopify, engineers open 3–5 PRs per day and review 5–10. The ability to resolve conflicts quickly, write clear commit messages, and understand branching strategy is tested in virtually every DevOps and Platform Engineering interview.

