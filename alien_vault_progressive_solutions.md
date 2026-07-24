# The Alien Vault — Progressive Solutions

This guide contains the progressive solution for Activities 1–10.

- Each activity builds on the previous one.
- Replace the earlier version of `vault.py` with the new version shown.
- Comments marked `NEW` or `CHANGED` identify the cutover for that activity.
- Activities 4 and 6 introduce separate exploit scripts.

---

## Activity 1 — The Empty Vault

### `vault.py`

```python
class AlienVault:
    def __init__(self):
        # NEW: The vault starts empty.
        self.occupant = None

    def capture(self, alien_name):
        # NEW: Store the captured alien inside the vault.
        self.occupant = alien_name
        print(f"SYSTEM: {alien_name} has been secured in the vault.")

    def __str__(self):
        # NEW: Return a readable description of the vault.
        return f"Vault occupant: {self.occupant}"


if __name__ == "__main__":
    vault = AlienVault()

    print(vault)
    vault.capture("Gorgax")
    print(vault)
```

Run:

```bash
python3 vault.py
```

---

## Activity 2 — Talking to the Alien

### `vault.py`

```python
class AlienVault:
    def __init__(self):
        self.occupant = None

    def capture(self, alien_name):
        self.occupant = alien_name
        print(f"SYSTEM: {alien_name} has been secured in the vault.")

    # NEW: A safe method for communicating with the alien.
    def greet_alien(self):
        if self.occupant is None:
            return "The vault is empty. Silence echoes back."

        return f"{self.occupant} responds with strange clicking sounds."

    def __str__(self):
        return f"Vault occupant: {self.occupant}"


if __name__ == "__main__":
    vault = AlienVault()

    # NEW: Test the greeting before and after capture.
    print(vault.greet_alien())

    vault.capture("Gorgax")
    print(vault.greet_alien())
```

Run:

```bash
python3 vault.py
```

---

## Activity 3 — The Danger of Open Controls

### `vault.py`

```python
class AlienVault:
    def __init__(self):
        self.occupant = None

        # NEW: Public environmental controls.
        self.containment_level = 100
        self.temperature = 20
        self.oxygen_level = 21

    def capture(self, alien_name):
        self.occupant = alien_name
        print(f"SYSTEM: {alien_name} has been secured in the vault.")

    def greet_alien(self):
        if self.occupant is None:
            return "The vault is empty. Silence echoes back."

        return f"{self.occupant} responds with strange clicking sounds."

    def __str__(self):
        # CHANGED: Display the new environmental controls.
        return (
            f"Occupant: {self.occupant}\n"
            f"Containment: {self.containment_level}%\n"
            f"Temperature: {self.temperature}°C\n"
            f"Oxygen: {self.oxygen_level}%"
        )


if __name__ == "__main__":
    vault = AlienVault()
    vault.capture("Gorgax")
    print(vault)
```

Run:

```bash
python3 vault.py
```

---

## Activity 4 — The First Escape

Keep the Activity 3 version of `vault.py`.

### `exploit.py`

```python
from vault import AlienVault


vault = AlienVault()
vault.capture("Gorgax")

print("Vault secured.")
print(vault)

print("\n--- Alien interference detected ---")

# NEW: External code directly changes a public attribute.
vault.containment_level = 0

print(vault)
print("The alien has escaped!")
```

Run:

```bash
python3 exploit.py
```

---

## Activity 5 — Protected Attributes

### `vault.py`

```python
class AlienVault:
    def __init__(self):
        self.occupant = None

        # CHANGED: Public attributes now use a single underscore.
        self._containment_level = 100
        self._temperature = 20
        self._oxygen_level = 21

    def capture(self, alien_name):
        self.occupant = alien_name
        print(f"SYSTEM: {alien_name} has been secured in the vault.")

    def greet_alien(self):
        if self.occupant is None:
            return "The vault is empty. Silence echoes back."

        return f"{self.occupant} responds with strange clicking sounds."

    def __str__(self):
        # CHANGED: Use the protected attribute names.
        return (
            f"Occupant: {self.occupant}\n"
            f"Containment: {self._containment_level}%\n"
            f"Temperature: {self._temperature}°C\n"
            f"Oxygen: {self._oxygen_level}%"
        )


if __name__ == "__main__":
    vault = AlienVault()
    vault.capture("Gorgax")
    print(vault)
```

Run:

```bash
python3 vault.py
```

---

## Activity 6 — The Alien Ignores Warnings

Keep the Activity 5 version of `vault.py`.

### `exploit_v2.py`

```python
from vault import AlienVault


vault = AlienVault()
vault.capture("Gorgax")

print(f"Initial containment: {vault._containment_level}%")

# NEW: The alien ignores the single-underscore convention.
vault._containment_level = 0

print(f"New containment: {vault._containment_level}%")
print("The alien ignored the warning and escaped again!")
```

Run:

```bash
python3 exploit_v2.py
```

---

## Activity 7 — Private Attributes

### `vault.py`

```python
class AlienVault:
    def __init__(self, occupant=None, containment_level=100):
        self.occupant = occupant

        # CHANGED: Double underscore triggers name mangling.
        self.__containment_level = containment_level

        self._temperature = 20
        self._oxygen_level = 21

    def capture(self, alien_name):
        self.occupant = alien_name
        print(f"SYSTEM: {alien_name} has been secured in the vault.")

    def greet_alien(self):
        if self.occupant is None:
            return "The vault is empty. Silence echoes back."

        return f"{self.occupant} responds with strange clicking sounds."

    def __str__(self):
        # CHANGED: The class can still access its private attribute.
        return (
            f"Occupant: {self.occupant}\n"
            f"Containment: {self.__containment_level}%"
        )


if __name__ == "__main__":
    vault = AlienVault("Gorgax", 100)

    print(vault)

    # NEW: Inspect the mangled attribute name.
    print(dir(vault))

    # NEW: This would raise AttributeError.
    # print(vault.__containment_level)
```

Run:

```bash
python3 vault.py
```

---

## Activity 8 — Building the Official Controls

### `vault.py`

```python
class AlienVault:
    def __init__(self, occupant=None, containment_level=100):
        self.occupant = occupant
        self.__containment_level = containment_level

        self._temperature = 20
        self._oxygen_level = 21

    def capture(self, alien_name):
        self.occupant = alien_name
        print(f"SYSTEM: {alien_name} has been secured in the vault.")

    def greet_alien(self):
        if self.occupant is None:
            return "The vault is empty. Silence echoes back."

        return f"{self.occupant} responds with strange clicking sounds."

    # NEW: Increase containment without going above 100.
    def reinforce(self, amount):
        self.__containment_level = min(
            100,
            self.__containment_level + amount
        )

    # NEW: Decrease containment without going below 0.
    def weaken(self, amount):
        self.__containment_level = max(
            0,
            self.__containment_level - amount
        )

    # NEW: Restore maximum containment immediately.
    def emergency_lockdown(self):
        self.__containment_level = 100

    # NEW: Safely return the current containment status.
    def get_status(self):
        return f"Containment: {self.__containment_level}%"

    def __str__(self):
        # CHANGED: Reuse get_status().
        return (
            f"Occupant: {self.occupant}\n"
            f"{self.get_status()}"
        )


if __name__ == "__main__":
    vault = AlienVault("Xenomorph-7", 50)

    print(vault)

    vault.reinforce(30)
    print(vault)

    vault.reinforce(50)
    print(vault)

    vault.weaken(150)
    print(vault)

    vault.emergency_lockdown()
    print(vault)
```

Run:

```bash
python3 vault.py
```

---

## Activity 9 — Alien Communication Console

### `vault.py`

```python
class AlienVault:
    def __init__(self, occupant=None, containment_level=100):
        self.occupant = occupant
        self.__containment_level = containment_level

        self._temperature = 20
        self._oxygen_level = 21

        # NEW: Private translation responses.
        self.__responses = {
            "hello": "Greetings, carbon-construct.",
            "escape": "Your structures are temporary.",
            "name": "I am designated Gorgax."
        }

    def capture(self, alien_name):
        self.occupant = alien_name
        print(f"SYSTEM: {alien_name} has been secured in the vault.")

    def greet_alien(self):
        if self.occupant is None:
            return "The vault is empty. Silence echoes back."

        return f"{self.occupant} responds with strange clicking sounds."

    def reinforce(self, amount):
        self.__containment_level = min(
            100,
            self.__containment_level + amount
        )

    def weaken(self, amount):
        self.__containment_level = max(
            0,
            self.__containment_level - amount
        )

    def emergency_lockdown(self):
        self.__containment_level = 100

    def get_status(self):
        return f"Containment: {self.__containment_level}%"

    # NEW: Public method that hides the translation logic.
    def ask(self, question):
        question = question.lower()

        for keyword in self.__responses:
            if keyword in question:
                return self.__responses[keyword]

        return "The alien stares blankly with its primary eyes."

    def __str__(self):
        return (
            f"Occupant: {self.occupant}\n"
            f"{self.get_status()}"
        )


if __name__ == "__main__":
    vault = AlienVault("Gorgax")

    # NEW: Test the communication console.
    print(vault.ask("Hello there, creature!"))
    print(vault.ask("What is your name?"))
    print(vault.ask("What is the meaning of life?"))
```

Run:

```bash
python3 vault.py
```

---

## Activity 10 — Properties

### Final `vault.py`

```python
class AlienVault:
    def __init__(self, occupant=None, containment_level=100):
        self.occupant = occupant
        self.__containment_level = containment_level

        self._temperature = 20
        self._oxygen_level = 21

        self.__responses = {
            "hello": "Greetings, carbon-construct.",
            "escape": "Your structures are temporary.",
            "name": "I am designated Gorgax."
        }

    # NEW: Read-only public access to the private containment level.
    @property
    def containment_level(self):
        return self.__containment_level

    def capture(self, alien_name):
        self.occupant = alien_name
        print(f"SYSTEM: {alien_name} has been secured in the vault.")

    def greet_alien(self):
        if self.occupant is None:
            return "The vault is empty. Silence echoes back."

        return f"{self.occupant} responds with strange clicking sounds."

    def reinforce(self, amount):
        self.__containment_level = min(
            100,
            self.__containment_level + amount
        )

    def weaken(self, amount):
        self.__containment_level = max(
            0,
            self.__containment_level - amount
        )

    def emergency_lockdown(self):
        self.__containment_level = 100

    def get_status(self):
        # CHANGED: Read through the property.
        return f"Containment: {self.containment_level}%"

    def ask(self, question):
        question = question.lower()

        for keyword in self.__responses:
            if keyword in question:
                return self.__responses[keyword]

        return "The alien stares blankly with its primary eyes."

    def __str__(self):
        # CHANGED: Display containment through the property.
        return (
            f"Alien Vault\n"
            f"Occupant: {self.occupant}\n"
            f"Containment: {self.containment_level}%\n"
            f"Temperature: {self._temperature}°C\n"
            f"Oxygen: {self._oxygen_level}%"
        )


if __name__ == "__main__":
    vault = AlienVault("Gorgax", 80)

    print(vault)
    print(f"\nDashboard level: {vault.containment_level}%")

    vault.weaken(30)
    print(vault)

    print(vault.ask("Can you escape?"))
```

Run:

```bash
python3 vault.py
```

---

## Final File Structure

```text
project/
├── vault.py
├── exploit.py
└── exploit_v2.py
```
