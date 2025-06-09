# Introduction to Git and Version Control Basics

**What is Version Control?** Version Control Systems (VCS) help track and manage changes to code or files over time, enabling collaboration, history tracking, and easy rollback.

**What is Git?** Git is a distributed version control system, allowing multiple people to work on a project simultaneously without interfering with each other's work.

## Git Installation and Configuration

1. **Install Git:**
   * Windows: Git for Windows
   * macOS: Use Homebrew: `brew install git`
   * Linux: Use package manager, e.g., Ubuntu: `sudo apt install git`

2. **Configure Git with your identity:**

```bash
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
```

## Basic Git Commands

| Command | Description |
|---------|-------------|
| `git init` | Initialize a new local Git repository |
| `git clone <repo-url>` | Clone an existing remote repository locally |
| `git add <file>` | Add file(s) to staging area for commit |
| `git commit -m "message"` | Commit staged changes with a descriptive message |
| `git push origin <branch>` | Push commits to remote repository branch |
| `git pull origin <branch>` | Fetch and merge remote changes into current branch |

## Task 1: Setup Remote Repo Locally, Add File, Commit & Push

1. **Clone remote repo:**

```bash
git clone https://github.com/username/repo-name.git
cd repo-name
```

2. **Add a file:**

```bash
echo "Hello, World!" > hello.txt
git add hello.txt
git commit -m "Add hello.txt with initial content"
```

3. **Push changes:**

```bash
git push origin main
```

*(Use `master` if your repo uses that branch name)*

## Task 2: Create Branch, Commit, Push & Merge via Pull Request

1. **Create and switch to new branch:**

```bash
git checkout -b new-feature
```

2. **Add changes & commit:**

```bash
echo "Feature work" > feature.txt
git add feature.txt
git commit -m "Add new feature"
```

3. **Push new branch:**

```bash
git push -u origin new-feature
```

4. **Create Pull Request (PR):**
   * Go to GitHub repo
   * Click "Compare & pull request" for your branch
   * Review and create PR to merge into `main` (or `master`)

5. **Merge PR:**
   * After review, click "Merge pull request" on GitHub
   * Optionally delete the feature branch

## Task 3: Undo Last Commit or Remove Last File from Remote Repo

* **Undo last commit but keep changes staged:**

```bash
git reset --soft HEAD~1
```

* **Undo last commit and discard changes:**

```bash
git reset --hard HEAD~1
```

* **Remove last pushed file from remote:**

```bash
git rm filename
git commit -m "Remove filename"
git push origin main
```

## Task 4: Branching, Merging & Resolving Merge Conflicts

1. **Switch to master and merge:**

```bash
git checkout master
git merge new-feature
```

2. **If conflicts arise, Git will show conflicted files.**

3. **Open conflicted files and resolve conflicts:**
   Look for conflict markers:

```text
<<<<<<< HEAD
Current branch code
=======
Incoming branch code
>>>>>>> new-feature
```

Edit to keep desired changes and remove markers.

4. **Stage resolved files:**

```bash
git add resolved-file.txt
```

5. **Commit merge resolution:**

```bash
git commit -m "Resolve merge conflicts"
```

## Task 5: Practice Additional Useful Git Commands

* Check repo status:

```bash
git status
```

* View commit history:

```bash
git log
```

* List branches:

```bash
git branch
```

* Switch/create branch:

```bash
git checkout -b branch-name
```

* Merge a branch:

```bash
git merge branch-name
```

* Stash changes temporarily:

```bash
git stash
```

* Apply stashed changes:

```bash
git stash apply
```

* Delete local branch:

```bash
git branch -d branch-name
```

* Fetch remote updates:

```bash
git fetch
```

* Rebase current branch on master:

```bash
git rebase master
```

## Recommended Resources for Deep Dive and Practice

* Official Pro Git Book: https://git-scm.com/book/en/v2
* Git Tutorial by freeCodeCamp (Video): https://www.youtube.com/watch?v=apGV9Kg7ics
