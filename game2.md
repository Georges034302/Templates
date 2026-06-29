# Game 2 – Round 1: Instructor Instructions

---

# Before Starting

Tell students:

1. Open your assigned team folder.
2. Edit only:

```text
round1_rules.py
```

3. Do **not** edit:

```text
round1_router.py
```

4. In this round, students will only modify the routing rule that decides whether a caller is allowed on air.

5. Test every change using:

```bash
python3 round1_router.py
```

or

```bash
python3 round1_router.py VegemiteFan
```

6. Commit and push only:

```text
round1_rules.py
```

---

# Turn 1 – Group B

## Public Instruction

> "Group B, make the first routing change. Group A, wait."

## Private Instruction to Group B

1. Open:

```text
round1_rules.py
```

2. Find:

```python
if caller_name == "VegemiteFan":
    on_air = True
else:
    on_air = True
```

3. Change the first condition so a different caller is checked instead.

Replace:

```python
if caller_name == "VegemiteFan":
```

with:

```python
if caller_name == "Alice":
```

4. Do not change the `on_air` assignments.

5. Test:

```bash
python3 round1_router.py VegemiteFan
```

and

```bash
python3 round1_router.py Alice
```

6. Commit and push:

```bash
git add round1_rules.py
git commit -m "Update caller routing rule"
git push
```

---

# Turn 2 – Group A

## Public Instruction

> "Group A, pull the latest changes, inspect the routing rule, and repair the system. Group B waits."

## Private Instruction to Group A

1. Pull the latest version:

```bash
git pull
```

2. Open:

```text
round1_rules.py
```

3. Find the modified condition, for example:

```python
if caller_name == "Alice":
```

4. Replace it with a fairer rule.

Option 1:

```python
if caller_name == "Alice" or caller_name == "Bob":
```

Option 2:

```python
if caller_name != "":
```

5. Leave the `on_air` assignments unchanged.

6. Test:

```bash
python3 round1_router.py Alice
python3 round1_router.py Bob
python3 round1_router.py VegemiteFan
```

7. Commit and push:

```bash
git add round1_rules.py
git commit -m "Repair routing rule"
git push
```

---

# Turn 3 – Group B

## Public Instruction

> "Group B, inspect the latest change and respond. Group A waits."

## Private Instruction to Group B

1. Pull the latest version:

```bash
git pull
```

2. Open:

```text
round1_rules.py
```

3. Find the routing condition.

4. Modify only the first line of the condition so that **VegemiteFan** is included again.

For example, change:

```python
if caller_name == "Alice" or caller_name == "Bob":
```

to:

```python
if caller_name == "Alice" or caller_name == "Bob" or caller_name == "VegemiteFan":
```

or adjust the condition so `VegemiteFan` is accepted again.

5. Do not modify any other code.

6. Test:

```bash
python3 round1_router.py VegemiteFan
```

7. Commit and push:

```bash
git add round1_rules.py
git commit -m "Adjust routing rule"
git push
```

---

# Turn 4 – Group A

## Public Instruction

> "Group A, make the final repair."

## Private Instruction to Group A

1. Pull the latest version:

```bash
git pull
```

2. Open:

```text
round1_rules.py
```

3. Find the routing condition.

4. Replace it with the final fair rule:

```python
if caller_name != "":
```

5. Leave the rest of the file unchanged.

6. Test:

```bash
python3 round1_router.py Alice
python3 round1_router.py Bob
python3 round1_router.py VegemiteFan
```

7. Confirm that valid callers are accepted.

8. Commit and push:

```bash
git add round1_rules.py
git commit -m "Final routing rule"
git push
```

---

# Freeze

Tell everyone:

```bash
git log --oneline
```

Review:

* What changed in the routing rule?
* Which commits introduced each change?
* How did Git help track the evolution of the code?

# Game 2 – Round 2: Instructor Instructions

---

# Before Starting

Tell students:

1. Open your assigned team folder.

2. Edit only:

```text
round2_rules.py
```

3. Do **not** edit:

```text
round2_router.py
```

4. In this round, students will only modify:

   * the `blocked_names` list, or
   * the loop that checks whether a caller is blocked.

5. Do not modify the final decision:

```python
if blocked:
    on_air = False
else:
    on_air = True
```

6. Test every change using:

```bash
python3 round2_router.py
```

7. Commit and push only:

```text
round2_rules.py
```

---

# Turn 1 – Group B

## Public Instruction

> "Group B, weaken the caller filter. Group A waits."

## Private Instruction to Group B

1. Open:

```text
round2_rules.py
```

2. Find:

```python
blocked_names = ["VegemiteFan", "SpamBot", "TrollGuy"]
```

3. Remove:

```python
"VegemiteFan"
```

so it becomes:

```python
blocked_names = ["SpamBot", "TrollGuy"]
```

4. Do not modify the loop or the final decision.

5. Test:

```bash
python3 round2_router.py
```

Confirm that **VegemiteFan** is no longer blocked.

6. Commit and push:

```bash
git add round2_rules.py
git commit -m "Remove VegemiteFan from blocked list"
git push
```

---

# Turn 2 – Group A

## Public Instruction

> "Group A, inspect the latest change and restore the caller filter. Group B waits."

## Private Instruction to Group A

1. Pull the latest version:

```bash
git pull
```

2. Open:

```text
round2_rules.py
```

3. Find:

```python
blocked_names = ["SpamBot", "TrollGuy"]
```

4. Add **VegemiteFan** back into the list so it becomes:

```python
blocked_names = ["VegemiteFan", "SpamBot", "TrollGuy"]
```

5. Leave the loop and final decision unchanged.

6. Test:

```bash
python3 round2_router.py
```

Confirm that **VegemiteFan** is blocked again.

7. Commit and push:

```bash
git add round2_rules.py
git commit -m "Restore blocked caller"
git push
```

---

# Turn 3 – Group B

## Public Instruction

> "Group B, inspect the latest change and attempt another bypass."

## Private Instruction to Group B

1. Pull the latest version:

```bash
git pull
```

2. Open:

```text
round2_rules.py
```

3. Find the loop:

```python
for name in blocked_names:
    if caller_name == name:
        blocked = True
```

4. Change only the comparison so **VegemiteFan** is ignored.

For example, replace:

```python
if caller_name == name:
```

with:

```python
if caller_name == name and caller_name != "VegemiteFan":
```

5. Leave the rest of the loop unchanged.

6. Test:

```bash
python3 round2_router.py
```

Confirm that **VegemiteFan** is allowed while the other blocked names are still rejected.

7. Commit and push:

```bash
git add round2_rules.py
git commit -m "Bypass VegemiteFan check"
git push
```

---

# Turn 4 – Group A

## Public Instruction

> "Group A, make the final repair."

## Private Instruction to Group A

1. Pull the latest version:

```bash
git pull
```

2. Open:

```text
round2_rules.py
```

3. Find the modified loop:

```python
for name in blocked_names:
    if caller_name == name and caller_name != "VegemiteFan":
        blocked = True
```

4. Restore the original comparison:

```python
for name in blocked_names:
    if caller_name == name:
        blocked = True
```

5. Do not modify the `blocked_names` list or the final decision.

6. Test:

```bash
python3 round2_router.py
```

Confirm that:

* `VegemiteFan` is blocked.
* `SpamBot` is blocked.
* `TrollGuy` is blocked.
* Other callers are allowed.

7. Commit and push:

```bash
git add round2_rules.py
git commit -m "Restore blocked caller logic"
git push
```

---

# Freeze

Tell everyone:

```bash
git log --oneline
```

Review:

* How did the `blocked_names` list affect the program?
* How did changing the loop affect the program?
* Which commits changed the data?
* Which commits changed the program logic?

