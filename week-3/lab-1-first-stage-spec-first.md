# Lab 1 — The First Stage, Spec First

**Works**: solo · **Needs**: `setup.md` done (the smoke check printed a reply and a parsed object), Claude Code, the OpenSpec CLI · work on branches, never `main`

You will build the pipeline's first stage twice — once by asking Claude Code for it, once through OpenSpec under a project context you wrote — and compare not just the diffs but *which LangChain* the two runs believed in.

## Scenario

The first stage reads `prd/notification-policy-prd.md` and produces structured requirements: identified FR/NFR items, each traceable to PRD text, plus the open questions a careful analyst would raise. It is a plain chain: prompt, model, typed output. The interesting question isn't whether Claude Code can write it. It's what it writes when nobody told it which LangChain year it is — or what shape DIAL's API has.

## Part A — The vibe baseline

Branch `lab-1-baseline`. **Fresh** Claude Code session in your project root (empty repo, `.env`, the PRD — nothing else). Say exactly:

> *add a stage that turns prd/notification-policy-prd.md into structured requirements using LangChain, talking to our DIAL endpoint configured in .env. Write the result to out/requirements.json.*

Let it finish; answer its questions minimally. Run what it built. Then record — and grep:

```
git diff main --stat
grep -rnE "AgentExecutor|initialize_agent|LLMChain|langchain\.chains|langchain_community|PydanticOutputParser|ConversationBufferMemory|openai_api_base|base_url" .
```

Hits in the first group are stale-API generation (last section of `reference-langchain-map.md`). Hits on `base_url` or `openai_api_base` mean it guessed DIAL is OpenAI-shaped; it is Azure-shaped, and the 404 you probably got is the proof. Baseline runs commonly produce both; that's the point. Return to `main`; keep the branch.

⏱️ Time-box Part A to 20 minutes. If nothing runs by then, record that too — it's a data point, not a failure.

## Part B — Project context, then a spec

Branch `lab-1-requirements`. Install OpenSpec into the project:

```
openspec init --tools claude
```

Now write the constitution: `openspec/config.yaml`. Every artifact this week — proposal, spec, design, tasks — is generated under it. Start from this and finish every `TODO`; each is a decision about *your* project:

```yaml
schema: spec-driven
context: |
  prd-pipeline: a LangChain pipeline that turns a PRD into requirements, architecture, test cases and code.
  Stack: Python 3.11+, langchain>=1.4,<2, langchain-openai>=1.6,<2, pydantic v2, pytest.
  Layout: src/prd_pipeline/ (package), tests/, prd/ (inputs), out/ (artifacts, gitignored). CLI: python -m prd_pipeline <command>.
  Model access: ONE factory, prd_pipeline.llm.get_model(deployment=None) -> AzureChatOpenAI built from
  DIAL_URL, DIAL_API_KEY, DIAL_API_VERSION, DIAL_DEPLOYMENT. Nothing else reads DIAL_* or constructs a client.
  LangChain 1.x only: ChatPromptTemplate, `|` composition, RunnableParallel/RunnableLambda,
  model.with_structured_output(PydanticModel), langchain.tools.tool, langchain.agents.create_agent + langchain.agents.middleware.
  Forbidden: AgentExecutor, initialize_agent, LLMChain, langchain.chains, langchain_community, langchain.memory,
  RAG, vector stores, embeddings.
  Stage contract: a stage is a function with Pydantic input and output; it writes out/<stage>.json and out/<stage>.md;
  stages never import each other — a pipeline module composes them.
  IDs: FR-n / NFR-n; everything downstream references IDs, never prose.
  Tests: pytest, never the network — mock the model (langchain_core.language_models.fake_chat_models.GenericFakeChatModel).
  TODO: error handling policy (what a stage raises, what it never swallows).
  TODO: logging — what a run must print so you can follow it.
  TODO: anything your team would insist on in code review.
rules:
  proposal:
    - "Name the LangChain constructs the change introduces in What Changes."
  specs:
    - "Every requirement about model output has a scenario for malformed or empty output."
    - "Scenarios are checkable without a live model call where possible."
  design:
    - "State which DIAL deployment(s) the change uses and why."
  tasks:
    - "Each task names the command that proves it done (a pytest path or a CLI invocation)."
```

Ten minutes here buys the rest of the week. Restart Claude Code so the `/opsx:*` commands load.

Fresh session:

> */opsx:propose add-requirements-stage: bootstrap the package per config.yaml, including the model factory prd_pipeline.llm.get_model. Add a stage that reads a PRD markdown file and produces a Requirements object — functional requirements FR-n and non-functional NFR-n, each with a testable SHALL statement and a quote from the PRD, plus open_questions listing ambiguities and contradictions with the IDs involved. Writes out/requirements.json and out/requirements.md. Plain chain with structured output; no tools, no agent. CLI: python -m prd_pipeline requirements \<prd-path>.*

Four artifacts appear in `openspec/changes/add-requirements-stage/`. **Do not apply yet.** Read them in order and edit:

1. `proposal.md` — is each capability named? Is the LangChain construct named (your config rule)?
2. `specs/requirements-stage/spec.md` — every requirement has at least one `#### Scenario:`. Add one yourself: *WHEN the PRD contains two conflicting statements THEN open_questions names both requirement IDs.* Four hashtags exactly — with three, the validator silently ignores it.
3. `design.md` — which deployment, which structured-output method, what happens on malformed model output.
4. `tasks.md` — each task names its verification command (your config rule again). Add a task if there is no test for your new scenario.

Then:

```
openspec validate add-requirements-stage --strict
```

> */opsx:apply*

Watch tasks get checked off. When it stops:

> */opsx:verify add-requirements-stage*

Read the report. Any CRITICAL → fix before continuing. Then `/opsx:archive`; say yes to sync. Your delta spec becomes `openspec/specs/requirements-stage/spec.md` — the living truth.

### Worksheet

| Signal                                                   | Vibe baseline        | Spec-driven                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| -------------------------------------------------------- | -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Legacy-API and wrong-endpoint grep hits                  | Yes                  |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Where the output schema was decided (chat / spec / code) | Code                 | Spec                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| Questions Claude asked you                               | None                 | None                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| Verification actually run (commands)                     | `python pipeline.py` | `".venv/Scripts/python.exe" -m prd_pipeline requirements prd/notification-policy.md` `".venv/Scripts/pytest.exe" tests/test_requirements_stage.py` `".venv/Scripts/pytest.exe" tests/test_requirements_writer.py` `".venv/Scripts/pytest.exe" tests/test_requirements_models.py` `".venv/Scripts/pytest.exe" tests/test_llm.py` `".venv/Scripts/pytest.exe" tests/test_cli.py` `".venv/Scripts/pytest.exe" tests/`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Files touched (`--stat`)                                 | `pipeline.py`        | 28 (13-17 actual code)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Tests written, and for which scenarios                   | No                   | Yes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| Open questions the stage found in the PRD                | None                 | - FR-1 and NFR-1 conflict: FR-1 does not include current time in the engine input interface, whereas NFR-1 states that current time is an input.<br><br>- FR-1 and FR-8 conflict: FR-8 specifies rules for customers belonging to an email-only enterprise account, but the customer schema in FR-1 contains no enterprise account identifier or field.<br><br>- FR-1, FR-7, and NFR-1 conflict: FR-7 requires enforcing a limit of at most one marketing notification per customer per week, but NFR-1 mandates no I/O and FR-1 does not supply prior notification history in the input interface.<br><br>- FR-4 contains an internal contradiction: FR-4 asserts that opted-out customers receive no notifications but also asserts transactional notifications are always sent regardless of preferences, without specifying precedence or how transactional event types are identified in FR-1.<br><br>- FR-3, FR-5, and FR-1 conflict: FR-3 requires notifications to be 'important' and FR-5 requires them to be 'non-urgent', but FR-1 does not define how these terms map to the provided importance values (low, normal, high, critical). |

## Part C — Open the hood: the chain

Run it: `python -m prd_pipeline requirements prd/notification-policy-prd.md`. Read the stage source and find the `ChatPromptTemplate`, the `with_structured_output` call with its Pydantic schema, and the `|` joining them. That is the entire LangChain of Lab 1. Then:

1. Print `usage_metadata` for the run. What did one page of PRD cost in tokens?
2. Pass a different deployment name into `get_model(...)` for this one call and run again. Did the schema survive? A 400 here is the "DIAL gotcha" in `reference-langchain-map.md`.
3. Open `out/requirements.md`. The PRD says *"Open questions: none."* How many did the stage find? Compare with your own reading — you did this by hand in Week 1 Lab 2. What did it miss? What did it invent?

## Part D — Open the hood: the spec

1. `openspec list --specs`, then read `openspec/specs/requirements-stage/spec.md`. Find the test for the scenario you added. If there is none, `/opsx:verify` should have said so. Did it?
2. `openspec/changes/archive/` holds the change; `openspec/specs/` holds the truth. State in one sentence the difference between this and Week 2's `docs/ai/plan-<slug>.md`.
3. Your `config.yaml` said *LangChain 1.x only* and *one model factory*. Run the Part A grep on this branch. Did the constitution hold?

## Part E — Reflect

Answer in 2–3 sentences each (in class: discuss as a group first):

1. Both runs used the same Claude. What made the difference — the spec, the context file, or the checkpoints where you edited artifacts? Rank them with evidence from your worksheet.
2. Which worksheet row would matter most on a real project six months in?
3. What would you add to `config.yaml` now that you've seen one round?

## What to submit

- The worksheet + both grep outputs
- Your edited `spec.md` (added scenario marked) and the `/opsx:verify` report
- `out/requirements.md` and reflections

💡 Keep `lab-1-requirements` — every later lab branches from the previous one. Delete `lab-1-baseline` after the comparison.
