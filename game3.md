# Game3.md

# The Midfield Drive – Instructor Teaching Sequence

---

# Part 1 – The Midfield Drive

## Step 1 – Introduce the Problem

Tell students:

* Open `midfield.py`.
* The `pass` branch has already been completed.
* Your job is to complete the missing `tackle` and `shoot` branches.

---

## Step 2 – Explain the Data

Show:

```python
match_events = ["pass", "pass", "pass", "tackle", "pass", "shoot"]
ball_position = 4
```

Explain:

* The field runs from **1–7**.
* The ball starts at **4** (midfield).
* Each item in `match_events` is processed by the loop.

---

## Step 3 – Explain the Loop

Show:

```python
for event in match_events:
```

Explain:

* One event is processed each iteration.
* The `pass` branch is already implemented.
* Students will implement the remaining branches.

---

## Step 4 – Student Task

Students complete:

### `tackle`

Implement:

```text
ball_position = ball_position - 1
```

### `shoot`

Implement a nested `if`:

```text
if ball_position >= 6
    print("GOAL!")
else
    print("MISSED!")
```

---

## Step 5 – Test

Run:

```bash
python3 midfield.py
```

Expected outcome:

* Final result is **GOAL!**

---

# Part 2 – The Midfield Drive: Reloaded

## Step 1 – Explain the New Representation

Tell students:

* Open `reloaded.py`.
* The field is now stored as a Python list.
* The ball is stored as an index.

Show:

```python
field = ['_', '_', '_', '_', '_', '_', '_']
ball_index = 3
field[ball_index] = '⚽'
```

Explain:

* Lists start at index **0**.
* The middle position is index **3**.
* `field[ball_index] = '⚽'` mutates one element of the list.

---

## Step 2 – Explain the Boundary

Explain:

* Valid indices are **0–6**.
* Index **7** does not exist.
* Accessing index 7 causes:

```text
IndexError: list assignment index out of range
```

---

## Step 3 – Student Task

Students complete:

### `tackle`

Implement:

```text
ball_index = ball_index - 1
```

Only when:

```text
ball_index > 0
```

### `shoot`

Implement:

```text
if ball_index == 6
    print("GOAL!")
else
    print("saved by the keeper")
```

Leave the field visualisation code unchanged.

---

## Step 4 – Test

Run:

```bash
python3 reloaded.py
```

---

# Part 3 – Interactive Edition

## Step 1 – Explain Input

Show:

```python
action = input("Choose your move (pass/tackle/shoot): ")
```

Explain:

* `input()` always returns a string.

---

## Step 2 – Explain Turn Number

Students complete:

```text
print("Turn: " + str(turn))
```

Explain:

* `str()` converts an integer into a string.

---

## Step 3 – Student Task

Complete every `TODO`.

Implement:

### pass

```text
ball_index = ball_index + 1
```

### tackle

```text
ball_index = ball_index - 1
```

Only when the ball is above index **0**.

### shoot

Implement:

```text
if ball_index == 6
    print(win message)
    break
else
    print(goalie saves)
```

### Invalid Input

Implement the final `else` branch.

Behaviour:

```text
Print a fumble message.
The ball does not move.
The turn is lost.
```

---

## Step 4 – Test

Run:

```bash
python3 interactive.py
```

Students should test:

* a winning game,
* a missed shot,
* an invalid command.

---

## Wrap-up

Review:

* `for` loops
* nested `if`
* lists
* list mutation
* list indexing
* `input()`
* `str()`
* `break`
* `else`
