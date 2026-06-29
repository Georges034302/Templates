# Game 3 – The Midfield Drive: Instructor Teaching 

---

# Part 1 – The Midfield Drive

## Step 1 – Open the starter code

Tell students:

1. Open:

```text
midfield.py
```

2. Do not modify:

```python
match_events = ["pass", "pass", "pass", "tackle", "pass", "shoot"]
ball_position = 4
```

3. Do not modify the completed `pass` branch.

---

## Step 2 – Complete the tackle branch

Tell students:

Find:

```python
elif event == "tackle":
    # TODO: pull the ball back by 1 and print what happened.
    pass
```

Replace it with:

```python
elif event == "tackle":
    ball_position = ball_position - 1
    print(f"Tackle! The ball moves back to position {ball_position}.")
```

Explain:

* The ball moves back one position whenever a tackle occurs.

---

## Step 3 – Complete the shoot branch

Tell students:

Find:

```python
elif event == "shoot":
    # TODO ...
    pass
```

Replace it with:

```python
elif event == "shoot":
    print("💥 SHOOT!")

    if ball_position >= 6:
        print("GOAL!")
    else:
        print("The goalie saves it.")
```

Explain:

* This is a nested `if`.
* The first decision checks whether the event is `"shoot"`.
* The second decision checks whether the ball is close enough to score.

---

## Step 4 – Test

Run:

```bash
python3 midfield.py
```

Expected output:

* The final shot should print:

```text
GOAL!
```

---

# Part 2 – The Midfield Drive: Reloaded

## Step 1 – Open the starter code

Tell students:

1. Open:

```text
reloaded.py
```

2. Do not modify the completed `pass` branch.

3. Do not modify or move the field visualisation code at the bottom of the loop.

---

## Step 2 – Complete the tackle branch

Tell students:

Find:

```python
elif event == "tackle":
    # TODO: pull the ball back by one slot, BUT never let ball_index go below 0.
    pass
```

Replace it with:

```python
elif event == "tackle":
    if ball_index > 0:
        ball_index = ball_index - 1

    print("⬅️ Tackle! The defence pushes the ball back.")
```

Explain:

* Only move the ball if it is above index 0.
* Never allow the index to become negative.

---

## Step 3 – Complete the shoot branch

Tell students:

Find:

```python
elif event == "shoot":
    # TODO ...
    pass
```

Replace it with:

```python
elif event == "shoot":

    print("💥 SHOOT!")

    if ball_index == 6:
        print("GOAL!")
    else:
        print("Saved by the keeper.")
```

Explain:

* This version uses `ball_index` instead of `ball_position`.
* A goal is only scored when the ball reaches index 6.

---

## Step 4 – Test

Run:

```bash
python3 reloaded.py
```

Confirm:

* The field redraws after every event.
* The ball never moves below index 0.
* The program finishes successfully.

---

# Part 3 – Interactive Edition

## Step 1 – Print the turn header

Tell students:

Find:

```python
# TODO: print a turn header like --- TURN 1 ---
```

Replace it with:

```python
print("--- TURN " + str(turn) + " ---")
```

Explain:

* `turn` is an integer.
* `str(turn)` converts it into text.

---

## Step 2 – Replace the placeholder

Tell students:

Find:

```python
pass
```

under this comment:

```python
# TODO: handle "pass", "tackle", and "shoot"
```

Replace the single `pass` statement with a complete `if / elif / else` structure.

---

## Step 3 – Implement the pass branch

Students should write:

```python
if action == "pass":
    ball_index = ball_index + 1
    print("➡️ Great pass!")
```

---

## Step 4 – Implement the tackle branch

Students should write:

```python
elif action == "tackle":
    if ball_index > 0:
        ball_index = ball_index - 1

    print("⬅️ Strong tackle!")
```

---

## Step 5 – Implement the shoot branch

Students should write:

```python
elif action == "shoot":

    print("💥 SHOOT!")

    if ball_index == 6:
        print("🏆 GOAL! You win the Python Cup!")
        break
    else:
        print("🧤 Saved by the keeper!")
```

Explain:

* `break` immediately ends the game after a goal.

---

## Step 6 – Implement the invalid command

Students should finish with:

```python
else:
    print("❌ Fumble! You lose this turn.")
```

Explain:

* The ball does not move.
* The turn is wasted.

---

## Step 7 – Test

Run:

```bash
python3 interactive.py
```

Test three scenarios:

1. Reach the goal and score.
2. Shoot too early.
3. Enter an invalid command.

Students should confirm that the game ends immediately after a goal.

---

# Wrap-up

Review:

* `for` loops
* `if / elif / else`
* nested `if`
* list indexing
* list mutation
* `input()`
* `str()`
* `break`
