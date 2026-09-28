# AI-Assisted Engineering Labs — Week 3 Student Pack

Week 1 taught you to direct AI and distrust it, in chat. Week 2 put Claude Code to work on your repo with skills and subagents. Week 3 flips the table: **you build the AI system**. Over five labs you write a LangChain pipeline that turns a product requirements document into requirements, architecture, test cases and passing code — on EPAM's DIAL gateway — and you build it **spec-first** with OpenSpec driving Claude Code.

Two layers, kept apart on purpose:

- **How you build it**: spec-driven development. Every feature starts as an OpenSpec change — proposal, delta spec, design, tasks — that Claude Code implements and you verify and archive into living specs.
- **What you build**: a plain LangChain 1.x program. It knows nothing about specs. It reads a PRD and produces artifacts, stage by stage, and by Lab 4 an agent orchestrates the stages.

The irony is deliberate. Your pipeline automates *PRD → requirements → tests → code*. You build it through *spec → tasks → code*. Lab 4 asks what your pipeline lacks that your own process has.

## What you need

- **Claude Code**, **Python 3.11+**, **Node 18+**, git — see `setup.md`
- A **DIAL API key** and two deployment names (one from another vendor), from your instructor or the DIAL portal
- The **OpenSpec CLI** (`npm install -g @fission-ai/openspec@latest`)
- `prd-notification-policy.md` from this pack — the input your pipeline consumes all week

## The labs

| # | Lab | You will practice |
|---|-----|-------------------|
| 1 | [The First Stage, Spec First](lab-1-first-stage-spec-first.md) | Chat model on DIAL, prompt templates, structured output · `openspec init`, the project context, propose → apply → verify → archive |
| 2 | [Chaining Stages](lab-2-chaining-stages.md) | Runnable composition, `RunnableParallel`, a human checkpoint, deterministic traceability · a second change under the same specs |
| 3 | [The Coder Agent](lab-3-the-coder-agent.md) | Tools, `create_agent`, human approval before writes, three kinds of limits · specifying tool contracts before code |
| 4 | [Orchestrating the Pipeline](lab-4-orchestrating-the-pipeline.md) | Specialists as tools, feedback loops, model fallback across DIAL deployments, cost accounting · a brownfield change with MODIFIED requirements, and a drift hunt |
| 5 | [LLM-as-a-Judge](lab-5-llm-as-a-judge.md) *(optional)* | A judge on a different deployment, rubric to typed verdict, calibrating it against yourself |

Labs are **strictly sequential** — each branches from the previous one and consumes its `out/` artifacts. Read `reference-langchain-map.md` before Lab 1 (it tells current LangChain from stale) and `reference-sdd-loop.md` alongside Lab 1 Part B.

## Ground rules

1. **Baseline before method.** Labs 1–3 each start with a run that has no spec or no pipeline. Skip it and you have nothing to compare against — Week 2's rule, still in force.
2. **Fresh sessions.** Every `/opsx:*` command in a fresh Claude Code session. Context from the baseline contaminates the spec-driven run.
3. **Edit the artifacts before `/opsx:apply`.** The spec is the checkpoint. If you never change a generated spec, you weren't in the loop.
4. **Never `main`.** One branch per lab, each from the previous.
5. **Tests never call DIAL.** Mock the model. A test that needs a key is an integration test and belongs elsewhere.
6. **Secrets stay in `.env`.** It is gitignored. Before every commit, `git status` should not list it.
7. **Record as you go.** The worksheets ask for token counts and pass rates; you won't remember them.
8. **Your code, your call.** DIAL is internal, the PRD is fictional. If you point the pipeline at a real PRD later, check your policy first.
