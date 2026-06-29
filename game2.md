# Game2.md

# The Great Vegemite Call-In War – Instructor Communication Script

This script is used during class. Students communicate **only through Git** by modifying the shared rules file.

---

# Round 1

## Before Starting

Remind everyone:

* Edit **only** `round1_rules.py`.
* Do **not** edit `round1_router.py`.
* Test every change before committing.
* Keep your private objective secret.

---

## Turn 1 – Group B

### Public

> "Group B, make the first routing change. Group A, wait."

### Private – Group B

Allow:

```text
VegemiteFan
```

Edit:

```text
round1_rules.py
```

Test:

```bash
python3 round1_router.py
```

or

```bash
python3 round1_router.py VegemiteFan
```

Commit:

```bash
git add round1_rules.py
git commit -m "Update caller rule"
git push
```

---

## Turn 2 – Group A

### Public

> "Group A, pull the latest changes, inspect the rule and make the system fair."

### Private – Group A

Run:

```bash
git pull
```

Open:

```text
round1_rules.py
```

Choose one repair:

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

Commit:

```bash
git add round1_rules.py
git commit -m "Make routing fairer"
git push
```

---

## Turn 3 – Group B

### Public

> "Group B, inspect the latest change and respond."

### Private – Group B

Run:

```bash
git pull
python3 round1_router.py VegemiteFan
```

Ensure **VegemiteFan** is still allowed.

Commit:

```bash
git add round1_rules.py
git commit -m "Adjust caller access"
git push
```

---

## Turn 4 – Group A

### Public

> "Group A, final repair."

### Private – Group A

Run:

```bash
git pull
```

Open:

```text
round1_rules.py
```

Choose a final fair rule.

Test:

```bash
python3 round1_router.py
```

Commit:

```bash
git add round1_rules.py
git commit -m "Final fair routing update"
git push
```

---

## Freeze

Everyone runs:

```bash
git log --oneline
```

---

# Round 2

## Before Starting

Remind everyone:

* Edit **only** `round2_rules.py`.
* Do **not** edit `round2_router.py`.
* Test every change before committing.
* Keep your private objective secret.

---

## Turn 1 – Group B

### Public

> "Group B, weaken the firewall. Group A, wait."

### Private – Group B

Choose **one** strategy:

* Remove **VegemiteFan** from the blocklist.
* Modify the rule so callers are always allowed.

Edit:

```text
round2_rules.py
```

Test:

```bash
python3 round2_router.py
```

or

```bash
python3 round2_router.py VegemiteFan
```

Commit:

```bash
git add round2_rules.py
git commit -m "Update round 2 rule"
git push
```

---

## Turn 2 – Group A

### Public

> "Group A, restore the firewall."

### Private – Group A

Run:

```bash
git pull
```

Inspect:

```text
round2_rules.py
```

Choose one repair:

* Restore or expand the blocklist.
* Restore the blocking logic.

Test:

```bash
python3 round2_router.py
```

Commit:

```bash
git add round2_rules.py
git commit -m "Restore firewall"
git push
```

---

## Turn 3 – Group B

### Public

> "Group B, inspect the latest change and attempt another bypass."

### Private – Group B

Run:

```bash
git pull
python3 round2_router.py VegemiteFan
```

Adjust your bypass if required.

Commit:

```bash
git add round2_rules.py
git commit -m "Adjust firewall bypass"
git push
```

---

## Turn 4 – Group A

### Public

> "Group A, final defence."

### Private – Group A

Run:

```bash
git pull
```

Inspect:

```text
round2_rules.py
```

Restore the intended behaviour and strengthen the firewall.

Test:

```bash
python3 round2_router.py
```

Commit:

```bash
git add round2_rules.py
git commit -m "Final firewall update"
git push
```

---

## Freeze

Everyone runs:

```bash
git log --oneline
```
