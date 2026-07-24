# The Alien Vault — Progressive Story and Solutions

Each activity builds on the previous activity.

> **How to use this guide**
>
> - Read the mission update first.
> - Replace the previous `vault.py` with the new version.
> - Comments marked `NEW` or `CHANGED` identify the cutover.
> - Activities 4 and 6 introduce separate exploit scripts.

---

## Activity 1 — The Empty Vault

> **Mission Update**
>
> - The temporary cage is failing.
> - The engineering team begins building a digital vault.
> - The vault must start empty.
> - The vault must store the captured alien.
> - Gorgax will be secured inside the first vault object.

### `vault.py`

```python
class AlienVault:
    def __init__(self):
        # NEW: The vault starts empty.
        self.occupant = None

    def capture(self, alien_name):
        # NEW: Store the captured alien.
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

---

## Activity 2 — Talking to the Alien

> **Mission Update**
>
> - Scientists need to communicate with the alien safely.
> - Opening the vault is too dangerous.
> - The team installs a software-controlled intercom.
> - The vault checks whether an alien is inside.
> - The alien responds through a controlled method.

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

---

## Activity 3 — The Danger of Open Controls

> **Mission Update**
>
> - The vault needs environmental controls.
> - The team adds containment, temperature, and oxygen levels.
> - All three controls are public.
> - External code can read or change them directly.
> - The alien detects the exposed controls.

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

---

## Activity 4 — The First Escape

> **Mission Update**
>
> - The alien launches its first software attack.
> - An external script changes the public containment level.
> - The containment level is forced to zero.
> - The vault performs no validation.
> - The containment field collapses and the alien escapes.

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

---

## Activity 5 — Protected Attributes

> **Mission Update**
>
> - The team marks the controls as internal.
> - A single underscore is added to each control name.
> - The underscore warns developers not to access the data directly.
> - The controls now appear protected.
> - The team must test whether Python enforces the warning.

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

---

## Activity 6 — The Alien Ignores Warnings

> **Mission Update**
>
> - The alien tests the protected controls.
> - It discovers that the underscore is only a convention.
> - Python still allows direct external access.
> - The alien changes containment to zero.
> - The alien escapes again.

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

---

## Activity 7 — Private Attributes

> **Mission Update**
>
> - The team replaces warnings with stronger digital locks.
> - The containment level receives a double underscore.
> - Python applies name mangling.
> - Normal external access now raises an error.
> - The private control is better protected from accidental access.

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
        # CHANGED: The class can access its private attribute.
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

---

## Activity 8 — Building the Official Controls

> **Mission Update**
>
> - Scientists still need a safe way to operate the vault.
> - The team creates official control methods.
> - `reinforce()` raises containment.
> - `weaken()` lowers containment.
> - `emergency_lockdown()` restores full containment.
> - `get_status()` reports the current level.
> - Containment remains between 0 and 100.

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

    # NEW: Restore maximum containment.
    def emergency_lockdown(self):
        self.__containment_level = 100

    # NEW: Safely report the containment level.
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

---

## Activity 9 — Alien Communication Console

> **Mission Update**
>
> - The physical vault is secure.
> - Scientists need a safer translation system.
> - Alien responses are stored in a private dictionary.
> - Questions are submitted through `ask()`.
> - The internal translation logic remains hidden.
> - The alien answers recognised questions safely.

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

    # NEW: Public method that hides translation logic.
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

    print(vault.ask("Hello there, creature!"))
    print(vault.ask("What is your name?"))
    print(vault.ask("What is the meaning of life?"))
```

---

## Activity 10 — Properties

> **Mission Update**
>
> - Operators want a simple containment dashboard.
> - The private containment level must remain protected.
> - The team adds a read-only property.
> - Operators can read the value using attribute syntax.
> - The private value cannot be changed through the property.
> - The final vault combines private data, controlled methods, and safe access.

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

    # NEW: Read-only public access to the private level.
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

---

## Mission Accomplished

> - The Alien Vault is complete.
> - Internal state is protected.
> - External code must use controlled interfaces.
> - The alien can no longer change containment directly.
> - Mars Base Alpha is secure.
