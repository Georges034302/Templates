# GAME2.md

# The Great Vegemite Call-In War – Instructor Communication Script

This script is used **during class**. It tells the instructor exactly what to say and what commands students should run.

---

# Before Starting

Remind everyone:

* Edit **only** `round1_rules.py`.
* Do **not** edit `round1_router.py`.
* Test every change before committing.
* Keep your private objective secret.

---

# Turn 1 – Group B Acts First

## Public Instruction

> "Something strange is happening at the radio station. Group B, you are making the first routing change. Group A, wait for your turn."

---

## Private Pumble Message – Group B

Your goal is to allow the caller:

```text
VegemiteFan
```

Open:

```text
round1_rules.py
```

Find:

```python
if caller_name == "Alice":
```

Modify the condition so **VegemiteFan** is allowed.

Test:

```bash
python3 round1_router.py
```

or

```bash
python3 round1_router.py VegemiteFan
```

Then run:

```bash
git add round1_rules.py
git commit -m "Update caller rule"
git push
```

Do **not** reveal your objective.

---

# Turn 2 – Group A Reacts

## Public Instruction

> "Group A, pull the latest changes, inspect the rule, and make the system fair. Group B, stop editing."

---

## Private Pumble Message – Group A

Run:

```bash
git pull
```

Open:

```text
round1_rules.py
```

Choose **one** repair:

```python
if caller_name == "Alice" or caller_name == "Bob":
```

or

```python
if caller_name != "":
```

Test:

```bash
python3 round1_router.py
```

Test at least one allowed caller and one rejected caller.

Then run:

```bash
git add round1_rules.py
git commit -m "Make routing fairer"
git push
```

Do **not** discuss your objective.

---

# Turn 3 – Group B Counters

## Public Instruction

> "Group B, pull the latest changes, inspect the rule, and respond. Group A, wait."

---

## Private Pumble Message – Group B

Run:

```bash
git pull
```

Open:

```text
round1_rules.py
```

Make sure **VegemiteFan** is still allowed.

Test:

```bash
python3 round1_router.py VegemiteFan
```

Then run:

```bash
git add round1_rules.py
git commit -m "Adjust caller access"
git push
```

Do **not** reveal your objective.

---

# Turn 4 – Group A Stabilises

## Public Instruction

> "Group A, final repair round. Pull the latest changes and make one final fair routing decision."

---

## Private Pumble Message – Group A

Run:

```bash
git pull
```

Open:

```text
round1_rules.py
```

Choose a fair rule.

Test at least:

* one caller who should be allowed
* one caller who should be rejected

Run:

```bash
python3 round1_router.py
```

Then:

```bash
git add round1_rules.py
git commit -m "Final fair routing update"
git push
```

---

# Freeze

## Public Instruction

> "Freeze! Hands off keyboards."

Everyone runs:

```bash
git log --oneline
```
