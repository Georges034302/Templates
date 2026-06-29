# Git Cheat Sheet

---

```bash
# Check the repository
git status

# View a compact commit history
git log --oneline
```

Example:

```text
9f8b2a1 Final firewall update
6c41e9a Restore firewall
3a11dcb Initial version
```

---

```bash
# View an older commit (Detached HEAD)
git checkout <commit-id>

# Return to the latest version
git checkout main
```

Example:

```bash
git checkout 6c41e9a
git checkout main
```

---

```bash
# Restore an older commit as the NEW current version
# (Keeps history)

git log --oneline
git restore --source=<commit-id> .
git add .
git commit -m "Restore project to previous version"
git push
```

History:

```text
A --- B --- C --- D
                  \
                   E  Restore project to B
```

---

```bash
# Make an old commit become the NEW HEAD
# (Rewrites history)

git log --oneline
git reset --hard <commit-id>
git push --force
```

History:

```text
Before

A --- B --- C --- D

After

A --- B
```

---

```bash
# Restore one file
git restore filename.py

# Restore all modified files
git restore .
```

---

```bash
# Create a branch
git branch feature-branch

# Create and switch to a branch
git checkout -b feature-branch

# List branches
git branch

# Switch branches
git checkout feature-branch

# Delete a merged branch
git branch -d feature-branch

# Force delete a branch
git branch -D feature-branch
```

---

```bash
# Merge a branch into the current branch
git checkout main
git merge feature-branch
```

---

```bash
# Replay commits on top of another branch
git checkout feature-branch
git rebase main
```

---

```bash
# Move branch, keep staged changes
git reset --soft <commit-id>

# Move branch, keep file changes
git reset --mixed <commit-id>

# Move branch, discard all changes
git reset --hard <commit-id>
```

---

```bash
# Typical workflow

# Download latest changes
git pull

# Check repository
git status

# Stage changes
git add .

# Create commit
git commit -m "Describe your changes"

# Upload commits
git push
```
