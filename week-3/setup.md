# Setup — before Lab 1

Thirty minutes, once. Everything below must work before Lab 1 Part A, because Lab 1 measures what Claude Code does with an empty repo, and an empty repo with a broken DIAL connection measures nothing.

## What you need

| Thing                | Check                                   | Notes                                                                                               |
| -------------------- | --------------------------------------- | --------------------------------------------------------------------------------------------------- |
| Python 3.11+         | `python3 --version`                     | macOS system Python is 3.9 — use `uv venv -p 3.12` or a pyenv/Homebrew install                      |
| Node 18+             | `node --version`                        | Only for the OpenSpec CLI                                                                           |
| git                  | `git --version`                         |                                                                                                     |
| Claude Code          | `claude --version`                      | Authenticated, as in Week 2                                                                         |
| A DIAL API key       | from your instructor or the DIAL portal | Personal. Treat it like a password                                                                  |
| Two deployment names | from the same place                     | One default (an OpenAI-family model such as `gpt-4o`), one from **another vendor** for labs 4 and 5 |
|                      |                                         |                                                                                                     |

⚠️ **Your code, your call** — Week 2 ground rule 6 still applies. DIAL is EPAM's internal gateway, which is why this week uses it; the PRD in this pack is fictional, so there's nothing to clear.

## 1. The project

```
mkdir prd-pipeline && cd prd-pipeline && git init
uv venv -p 3.12 && source .venv/bin/activate           # or: python3.12 -m venv .venv && source .venv/bin/activate
pip install "langchain>=1.4,<2" "langchain-openai>=1.6,<2" "pydantic>=2.7" python-dotenv pytest
pip freeze > requirements.txt
printf '.env\n.venv/\n__pycache__/\n.pytest_cache/\nout/\n' > .gitignore
mkdir prd && cp <this-pack>/prd-notification-policy.md prd/notification-policy-prd.md'
```

The version pins matter. LangChain 1.x is a different library from what most training data describes; `reference-langchain-map.md` exists because of that.

## 2. Secrets

Create `.env` — it is gitignored, keep it that way:

```
DIAL_URL=https://<your-dial-host>        # no trailing slash, no /openai suffix
DIAL_API_KEY=<your key>
DIAL_API_VERSION=2024-10-21              # supports json_schema structured output
DIAL_DEPLOYMENT=gpt-4o                   # your default; must be in the list step 3 prints
DIAL_DEPLOYMENT_FALLBACK=<other vendor>  # Lab 4
DIAL_DEPLOYMENT_JUDGE=<other vendor>     # Lab 5
```

## 3. The smoke check

DIAL speaks the Azure OpenAI dialect, so LangChain's `AzureChatOpenAI` talks to it unchanged. Paste this into `python -` (or a scratch file you delete afterwards — this is not part of your project):

```python
import os, openai
from dotenv import load_dotenv; load_dotenv()
from langchain_openai import AzureChatOpenAI
from pydantic import BaseModel

url, key, ver, dep = os.environ["DIAL_URL"].rstrip("/"), os.environ["DIAL_API_KEY"], os.environ["DIAL_API_VERSION"], os.environ["DIAL_DEPLOYMENT"]
print("deployments:", sorted(m.id for m in openai.AzureOpenAI(azure_endpoint=url, api_key=key, api_version=ver).models.list().data))

model = AzureChatOpenAI(azure_endpoint=url, api_key=key, api_version=ver, azure_deployment=dep, temperature=0)
reply = model.invoke("Reply with exactly the two words: DIAL OK")
print("reply:", reply.content, "| tokens:", reply.usage_metadata)

class Greeting(BaseModel):
    language: str
    greeting: str
print("structured:", model.with_structured_output(Greeting).invoke("Greet me in Portuguese."))
```

Expected: a list of deployment names that includes yours, `DIAL OK` with a token count, and a `Greeting(...)` object. Commit an empty `main` (`.gitignore`, `requirements.txt`, `prd/`) and you're ready.

| If you see… | It means | Fix |
|-------------|----------|-----|
| `APIConnectionError` | Can't reach the host | VPN? Typo in `DIAL_URL`? |
| `401` | Key rejected | Check `DIAL_API_KEY` |
| `404` on the completion | Deployment name wrong | Use one from the printed list |
| `400` on the structured call only | This deployment or API version doesn't support `json_schema` | `DIAL_API_VERSION=2024-10-21` or newer; or `with_structured_output(Greeting, method="function_calling")` |
| Nothing printed for `tokens` | Deployment doesn't return usage | Lab 4's cost accounting needs `stream_usage=True`; note it now |

## 4. OpenSpec

```
npm install -g @fission-ai/openspec@latest
openspec --version        # 1.3 or newer
```

**Do not run `openspec init` yet** — Lab 1 does that on purpose, after the baseline.

## 5. Optional but wise

Run `claude` once in the project and check it can see `.env` is gitignored (`git check-ignore .env`). Lab 1's baseline will ask Claude Code to talk to DIAL "configured in .env"; you want to know before then that the file is where it looks.
