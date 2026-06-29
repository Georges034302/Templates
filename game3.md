# Game 3 – The Midfield Drive: Instructor Teaching Sequence

---

# Part 1 – The Midfield Drive

## Before Starting

Tell students:

* Open `midfield.py`.
* Do **not** modify the starter variables.
* The `pass` branch has already been completed.
* Your job is to complete only the missing `tackle` and `shoot` branches.

---

## Step 1 – Explain the Starting Code

Show:

```python
match_events = ["pass", "pass", "pass", "tackle", "pass", "shoot"]
ball_position = 4
```

Explain:

* The field runs from positions **1–7**.
* The ball starts at midfield (position **4**).
* The loop processes one event at a time.

---

## Step 2 – Student Task

Students should edit only the missing code inside:

```python
elif event == "tackle":
```

and

```python
elif event == "shoot":
```

---

### Tackle

Implement:

```python
ball_position = ball_position - 1
```

---

### Shoot

Inside the `shoot` branch, add a nested `if`.

If:

```python
ball_position >= 6
```

print:

```text
GOAL!
```

otherwise print:

```text
MISSED!
```

---

## Step 3 – Test

Run:

```bash
python3 midfield.py
```

Expected result:

* The final shot should print:

```text
GOAL!
```

---

# Part 2 – The Midfield Drive: Reloaded

## Before Starting

Tell students:

* Open `reloaded.py`.
* Do **not** modify the field visualisation code.
* The `pass` branch is already complete.
* Complete only the missing `tackle` and `shoot` branches.

---

## Step 1 – Explain the Field

Show:

```python
field = ['_', '_', '_', '_', '_', '_', '_']
ball_index = 3
```

Explain:

* Lists begin at index **0**.
* The middle position is index **3**.
* The ball moves by changing the index.

---

## Step 2 – Student Task

Students edit only:

```python
elif event == "tackle":
```

and

```python
elif event == "shoot":
```

---

### Tackle

Decrease the ball position only when:

```python
ball_index > 0
```

using:

```python
ball_index = ball_index - 1
```

---

### Shoot

Implement:

```python
if ball_index == 6:
```

print:

```text
GOAL!
```

otherwise print:

```text
saved by the keeper
```

Leave the field drawing code unchanged.

---

## Step 3 – Test

Run:

```bash
python3 reloaded.py
```

Confirm:

* The field redraws after every event.
* The program finishes without errors.

---

# Part 3 – Interactive Edition

## Before Starting

Tell students:

* Open `interactive.py`.
* Do not change the game setup.
* Complete every section marked `TODO`.
* Leave the field visualisation block inside the loop.

---

## Step 1 – Turn Header

Students complete:

```python
print("Turn " + str(turn))
```

Explain:

* `str()` converts the turn number into a string.

---

## Step 2 – Student Task

Complete the action handling.

---

### pass

Implement:

```python
ball_index = ball_index + 1
```

---

### tackle

Implement:

```python
if ball_index > 0:
    ball_index = ball_index - 1
```

---

### shoot

Add a nested `if`.

If:

```python
ball_index == 6
```

print a win message and execute:

```python
break
```

Otherwise print the save message.

---

### Invalid Input

Complete the final:

```python
else:
```

Print a fumble message.

Do not move the ball.

The player loses that turn.

---

## Step 3 – Test

Run:

```bash
python3 interactive.py
```

Students should test:

* reaching the goal,
* shooting too early,
* entering an invalid command,
* confirming the game ends immediately after scoring.

---

# Wrap-up

Review the concepts introduced:

* `for` loops
* nested `if` statements
* list indexing
* list mutation
* `input()`
* `str()`
* `break`
* `else`
