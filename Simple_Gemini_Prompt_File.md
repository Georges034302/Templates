# Simple Gemini Prompt File Example

## Purpose

This example shows how to:

- read a prompt from a text file
- send that prompt to Gemini
- print Gemini's response
- choose the prompt file from the command line

---

## Script

Save as `ask.py`:

```python
import sys
import os
import google.generativeai as genai

filename = sys.argv[1]

genai.configure(api_key=os.environ["GEMINI_API_KEY"])
model = genai.GenerativeModel("gemini-2.0-flash")

with open(filename, "r") as f:
    prompt = f.read()

response = model.generate_content(prompt)

print(response.text)
```

---

## Prompt File

Example `context.txt`:

```text
You are a helpful assistant for WildSafe Australia.

WildSafe is a wildlife rescue organisation operating across Australia.
It rescues injured native animals and works with rescue centres in NSW, QLD, VIC, TAS, and SA.

Your task:
- Summarise the information briefly.
- Identify the most important facts.
- Do not invent information that is not provided.
```

---

## Usage

Set the Gemini API key:

```bash
export GEMINI_API_KEY="YOUR_API_KEY"
```

Run:

```bash
python ask.py context.txt
```

The script reads `context.txt`, sends its contents to Gemini, and prints the response.
