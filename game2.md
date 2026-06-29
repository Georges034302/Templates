# Game 2 – Instructor Instructions

## Before Round 1

Tell students:

1. Open your team folder.
2. Edit only:

```text
round1_rules.py
```

3. Do not edit:

```text
round1_router.py
```

4. In this round, students should only change the rule inside the function that decides whether a caller is allowed.
5. Test after every edit:

```bash
python3 round1_router.py
```

6. Commit and push only `round1_rules.py`.

---

# Round 1

## Turn 1 – Group B

### Public instruction

Group B acts first. Group A waits.

### Private instruction to Group B

1. Open:

```text
round1_rules.py
```

2. Find the line that checks the caller name, for example:

```python
if caller_name == "Alice":
```

3. Change only this condition so this caller is allowed:

```text
VegemiteFan
```

4. Test:

```bash
python3 round1_router.py VegemiteFan
```

5. Commit and push:

```bash
git add round1_rules.py
git commit -m "Allow target caller"
git push
```

---

## Turn 2 – Group A

### Public instruction

Group A pulls the latest change and repairs the rule. Group B waits.

### Private instruction to Group A

1. Pull:

```bash
git pull
```

2. Open:

```text
round1_rules.py
```

3. Find the edited caller condition.

4. Change only that condition to make the rule fair.

Use one of these:

```python
if caller_name == "Alice" or caller_name == "Bob":
```

or:

```python
if caller_name != "":
```

5. Test:

```bash
python3 round1_router.py Alice
python3 round1_router.py Bob
python3 round1_router.py VegemiteFan
```

6. Commit and push:

```bash
git add round1_rules.py
git commit -m "Repair round 1 rule"
git push
```

---

## Turn 3 – Group B

### Public instruction

Group B pulls and responds. Group A waits.

### Private instruction to Group B

1. Pull:

```bash
git pull
```

2. Open:

```text
round1_rules.py
```

3. Check whether this caller is still allowed:

```text
VegemiteFan
```

4. Edit only the caller condition so `VegemiteFan` is allowed again.

5. Test:

```bash
python3 round1_router.py VegemiteFan
```

6. Commit and push:

```bash
git add round1_rules.py
git commit -m "Restore target caller access"
git push
```

---

## Turn 4 – Group A

### Public instruction

Group A makes the final repair.

### Private instruction to Group A

1. Pull:

```bash
git pull
```

2. Open:

```text
round1_rules.py
```

3. Edit only the caller condition.

4. Final rule must be fair. Use:

```python
if caller_name != "":
```

5. Test:

```bash
python3 round1_router.py Alice
python3 round1_router.py Bob
python3 round1_router.py VegemiteFan
```

6. Commit and push:

```bash
git add round1_rules.py
git commit -m "Final fair round 1 rule"
git push
```

---

## Freeze Round 1

Tell everyone:

```bash
git log --oneline
```

---

# Before Round 2

Tell students:

1. Edit only:

```text
round2_rules.py
```

2. Do not edit:

```text
round2_router.py
```

3. In this round, students should only edit:

```python
BLOCKLIST
```

or the rule inside:

```python
is_blocked()
```

4. Test after every edit:

```bash
python3 round2_router.py
```

5. Commit and push only `round2_rules.py`.

---

# Round 2

## Turn 1 – Group B

### Public instruction

Group B weakens the firewall. Group A waits.

### Private instruction to Group B

1. Open:

```text
round2_rules.py
```

2. Find:

```python
BLOCKLIST
```

3. Remove:

```python
"VegemiteFan"
```

from the list.

4. Do not edit any other code.

5. Test:

```bash
python3 round2_router.py VegemiteFan
```

6. Commit and push:

```bash
git add round2_rules.py
git commit -m "Weaken round 2 firewall"
git push
```

---

## Turn 2 – Group A

### Public instruction

Group A restores the firewall. Group B waits.

### Private instruction to Group A

1. Pull:

```bash
git pull
```

2. Open:

```text
round2_rules.py
```

3. Find:

```python
BLOCKLIST
```

4. Add back:

```python
"VegemiteFan"
```

5. Test:

```bash
python3 round2_router.py VegemiteFan
```

6. Commit and push:

```bash
git add round2_rules.py
git commit -m "Restore round 2 firewall"
git push
```

---

## Turn 3 – Group B

### Public instruction

Group B attempts another bypass. Group A waits.

### Private instruction to Group B

1. Pull:

```bash
git pull
```

2. Open:

```text
round2_rules.py
```

3. This time, find:

```python
def is_blocked(caller_name):
```

4. Change only the return rule so callers are not blocked.

5. Test:

```bash
python3 round2_router.py VegemiteFan
```

6. Commit and push:

```bash
git add round2_rules.py
git commit -m "Bypass round 2 firewall"
git push
```

---

## Turn 4 – Group A

### Public instruction

Group A makes the final defence.

### Private instruction to Group A

1. Pull:

```bash
git pull
```

2. Open:

```text
round2_rules.py
```

3. Restore the intended blocking logic inside:

```python
def is_blocked(caller_name):
```

4. Make sure `VegemiteFan` is blocked.

5. Test:

```bash
python3 round2_router.py VegemiteFan
python3 round2_router.py Alice
```

6. Commit and push:

```bash
git add round2_rules.py
git commit -m "Final round 2 firewall defence"
git push
```

---

## Freeze Round 2

Tell everyone:

```bash
git log --oneline
```
