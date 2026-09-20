# Simple Gemini CLI

## Scope

This example provides a simple interactive Python script for using Gemini.

The script supports:

* asking Gemini a question
* sending the contents of a text file as context
* quitting through a simple menu

## Requirements

Install the Gemini SDK:

```bash
pip install google-genai
python -m pip install -U google-genai
```

Set your Gemini API key:

```bash
export GEMINI_API_KEY="YOUR_API_KEY"
```

## Script

Save as `ask.py`:

```python
from google import genai


client = genai.Client()
MODEL = "gemini-3.8-flash"


def ask(question):
    return client.models.generate_content(
        model=MODEL,
        contents=question,
    ).text


def ask_with_context(filename):
    with open(filename, encoding="utf-8") as f:
        context = f.read()

    return ask(context)


while True:
    print("\n[a] Ask")
    print("[c] Ask with context")
    print("[q] Quit")

    choice = input("Choice: ").lower()

    match choice:
        case "a":
            question = input("Question: ")
            print(ask(question))

        case "c":
            filename = input("Context file: ")
            print(ask_with_context(filename))

        case "q":
            break

        case _:
            print("Invalid option")
```

## Usage

Run the script:

```bash
python ask.py
```

Menu:

```text
[a] Ask
[c] Ask with context
[q] Quit
Choice:
```

Ask a question:

```text
Choice: a
Question: What is generative AI?
```

Use a context file:

```text
Choice: c
Context file: context.txt
```

Quit:

```text
Choice: q
```
