# GAME1.md

# Mission Control – Instructor Communication Script

This script is used **during class**. It tells the instructor exactly what to say and what commands students should run.

---

# Round 1 – Local Commit

## Send to Pilots (Private Pumble Channel)

Ask the Pilots to write the following message into `pilot_log.txt`.

```text
Pilot Transmission 1:

Control Tower, this is Flight Wombat-27. We are crossing the Australian desert and something strange is happening in the cargo hold. We can hear loud scratching, fast footsteps, and what sounds like tap dancing on a metal floor. Requesting guidance.
```

Then tell the Pilots to run:

```bash
git add .
git commit -m "Add first pilot transmission"
```

**Do NOT tell them to push yet.**

---

## Send to Mission Control (Private Pumble Channel)

Tell Mission Control to open `pilot_log.txt`.

They should **not** see the Pilot's message yet.

Explain:

> The Pilot has committed the changes locally, but the message has not yet reached the satellite.

Now introduce:

```bash
git push
```

Tell the Pilots to run:

```bash
git push
```

---

# Round 2 – First Pull

Tell Mission Control to check the Pilot file again.

They should still **not** see the message.

Explain:

> The message has reached the satellite, but your local repository has not downloaded it yet.

Now introduce:

```bash
git pull
```

Tell Mission Control to run:

```bash
git pull
```

Mission Control should now see the Pilot message.

Ask Mission Control to write the following into `mission_control_log.txt`.

```text
Control Tower Transmission 1:

Flight Wombat-27, we read you. Please inspect the cargo hold carefully. Do not touch any unknown animal, machine, crate, switch, snack box, or suspiciously energetic bird. Report what you find.
```

Then tell Mission Control to run:

```bash
git add .
git commit -m "Add first control tower response"
git push
```

Now tell the Pilots to run:

```bash
git pull
```

Pilots should now read the response.

---

# Round 3 – The Emu Is Discovered

## Send to Pilots

Ask the Pilots to append the following message to `pilot_log.txt`.

```text
Pilot Transmission 2:

Control Tower, we investigated the cargo hold. We found the problem. An emu has escaped from its transport crate. It has also eaten most of the emergency snack supply, including jelly snakes, chocolate biscuits, and powdered doughnuts. The emu appears to be extremely energetic.
```

Pilots run:

```bash
git add .
git commit -m "Report escaped emu"
git push
```

---

## Send to Mission Control

Mission Control runs:

```bash
git pull
```

Then writes:

```text
Control Tower Transmission 2:

Flight Wombat-27, confirm: did you say an emu has eaten the emergency sugar supply? Please keep the emu away from the cockpit. Close any doors between the cargo hold and the flight deck if possible.
```

Mission Control runs:

```bash
git add .
git commit -m "Ask pilots to secure cockpit"
git push
```

---

# Round 4 – The Emu Reaches the Cockpit

Tell the Pilots to run:

```bash
git pull
```

Then append:

```text
Pilot Transmission 3:

Control Tower, negative. We were unable to close the door in time. The emu sprinted down the passageway and entered the cockpit. It is now pecking buttons, stepping on switches, and staring very intensely at anything that flashes.
```

Pilots run:

```bash
git add .
git commit -m "Report emu in cockpit"
git push
```

---

Mission Control runs:

```bash
git pull
```

Then writes:

```text
Control Tower Transmission 3:

Flight Wombat-27, remain calm. Tell us exactly which systems the emu has touched. Do not make sudden movements. Try to distract it with something boring, such as the safety manual.
```

Mission Control runs:

```bash
git add .
git commit -m "Request cockpit damage report"
git push
```

---

# Round 5 – The Emu Presses Buttons

Tell the Pilots to run:

```bash
git pull
```

Then append:

```text
Pilot Transmission 4:

Control Tower, the emu has activated the windscreen wipers, turned on the seatbelt sign, opened the drinks compartment, and somehow changed the cabin music to a didgeridoo remix. It ignored the safety manual completely.
```

Pilots run:

```bash
git add .
git commit -m "Report cockpit button chaos"
git push
```

---

Mission Control runs:

```bash
git pull
```

Then writes:

```text
Control Tower Transmission 4:

Flight Wombat-27, understood. Keep the emu away from any red buttons. Red buttons are rarely good news. Repeat: do not allow the emu to touch a red button.
```

Mission Control runs:

```bash
git add .
git commit -m "Warn pilots about red button"
git push
```

---

# Round 6 – The Emu Escapes

Tell the Pilots to run:

```bash
git pull
```

Then append:

```text
Pilot Transmission 5:

Control Tower, update: the emu touched the red button. A side hatch opened. A small emergency parachute pack fell from storage. The emu stared at the parachute, then put it on. It jumped!
```

Pilots run:

```bash
git add .
git commit -m "Report parachute situation"
git push
```

---

Mission Control runs:

```bash
git pull
```

Then writes:

```text
Control Tower Transmission 5:

Flight Wombat-27, ...
```

Allow Mission Control to invent the funniest possible response.

Mission Control finishes with:

```bash
git add .
git commit -m "Ask whether emu is still onboard"
git push
```
