# Game3.md

# The Midfield Drive – Instructor Guide

---

# Part 1 – The Midfield Drive

## Instructor

Tell students:

* Open `midfield.py`.
* Complete the missing **`tackle`** and **`shoot`** branches.
* Do **not** modify the starter code.
* Run the program after every change.

Run:

```bash
python3 midfield.py
```

Walk around and ask:

* What should a tackle do?
* When should a shot become **GOAL!**?
* Why does `shoot` need another `if` statement?

Do **not** give the solution immediately.

---

## Freeze

Run:

```bash
python3 midfield.py
```

Brief discussion:

* How does the loop update the ball position?
* Why is there a nested `if` inside `shoot`?

---

# Part 2 – The Midfield Drive: Reloaded

## Instructor

Tell students:

* Open `reloaded.py`.
* Complete the missing **`tackle`** and **`shoot`** branches.
* Keep the field visualisation code unchanged.
* Run the program after every change.

Run:

```bash
python3 reloaded.py
```

Walk around and ask:

* Why does the field start at index **0**?
* What happens if the index becomes **7**?
* What is the difference between changing a variable and changing a list element?

If students encounter an `IndexError`, use it to explain list boundaries.

---

## Freeze

Run:

```bash
python3 reloaded.py
```

Brief discussion:

* What is list mutation?
* Why must the index stay between **0** and **6**?

---

# Part 3 – Interactive Edition

## Instructor

Tell students:

* Open `interactive.py`.
* Complete every `TODO`.
* Test after every change.

Run:

```bash
python3 interactive.py
```

Walk around and ask:

* Why does `input()` always return a string?
* Why do we use `str(turn)`?
* Where should `break` be placed?
* What should happen when the player enters an invalid command?

Do **not** give the code. Guide students with questions.

---

## Freeze

Run:

```bash
python3 interactive.py
```

Brief discussion:

* How does `break` end the game?
* Why is `else` useful for invalid input?
* What new Python concepts did you use in this game?
