# Simple Gemini Prompt File Example

## Requirements

Install the Gemini Python package:

```bash
pip install google-generativeai
```

The script uses:

```python
import google.generativeai as genai

python -m pip install -U google-genai
```

Set your API key:

```bash
export GEMINI_API_KEY="YOUR_API_KEY"
```

## Script

Save as `ask.py`:

```python
import sys

from google import genai


client = genai.Client()
MODEL = "gemini-3.8-flash"


def ask(question):
    response = client.models.generate_content(
        model=MODEL,
        contents=question,
    )
    return response.text


def ask_with_context(context_file, question):
    with open(context_file, encoding="utf-8") as f:
        context = f.read()

    return ask(f"{context}\n\n{question}")


context_file = sys.argv[1] if len(sys.argv) > 1 else None
question = sys.stdin.read().strip() if not sys.stdin.isatty() else None


match (context_file, question):
    case (None, str(question)):
        print(ask(question))

    case (str(filename), None):
        with open(filename, encoding="utf-8") as f:
            print(ask(f.read()))

    case (str(filename), str(question)):
        print(ask_with_context(filename, question))

    case _:
        print("Usage: python ask.py [context.txt] [< question]")
```

## Context File

Example `context.txt`:

```text
You are a helpful assistant for WildSafe Australia.

WildSafe is a wildlife rescue organisation operating across Australia.
It rescues injured native animals and works with rescue centres in NSW,
QLD, VIC, TAS, and SA.

Do not invent information that is not provided.
```

## Usage

Question only:

```bash
echo "What is DevOps?" | python ask.py
```

Context only:

```bash
python ask.py context.txt
```

Context and question:

```bash
echo "Summarise this organisation" | python ask.py context.txt
```

Question from a file:

```bash
python ask.py context.txt < question.txt
```
