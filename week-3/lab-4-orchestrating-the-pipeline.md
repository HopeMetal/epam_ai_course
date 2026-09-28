# Lab 4 — Orchestrating the Pipeline

**Works**: solo · **Needs**: labs 1–3, and a second deployment in `.env` as `DIAL_DEPLOYMENT_FALLBACK` — ideally from another vendor

You will replace the fixed stage order with an orchestrator agent whose tools are your stages, give it a reason to send work backwards, make it survive a dead deployment, and then decide with numbers whether the agency was worth it.

## Scenario

Today the pipeline is `requirements → design → code`, wired by you. When the coder reports *FR-7 cannot be implemented as specified* — and it will; the PRD guarantees it — the run simply ends. An orchestrator can do what you would: send the finding back to the analyst, re-derive, re-run. Or it can go in circles. Today you build it, bound it, price it, and compare. It is also your first **brownfield** OpenSpec change: existing behavior changes, and the living specs must say so.

## Part A — Baseline: the fixed pipeline, end to end

```
rm -rf out && python -m prd_pipeline requirements prd/notification-policy-prd.md && python -m prd_pipeline design && python -m prd_pipeline code
```

Record wall clock, total tokens, tests passing, and the coder report's `blocked_on` list. That list is the orchestrator's job description.

## Part B — The orchestrator, as a brownfield change

Branch `lab-4-orchestrator` from `lab-3-coder`. Fresh session. Explore first — this change touches existing specs:

> */opsx:explore how should an orchestrator agent coordinate the four existing stages, given openspec/specs/? Which existing requirements change?*

Then:

> */opsx:propose add-orchestrator: an orchestrator agent (create_agent) whose tools wrap the existing stages — run_requirements(prd_path, feedback), run_design(decisions), run_coder(), read_artifact(name) and ask_human(question). Its job: produce passing code for a PRD. Rules in its system prompt: never run_coder before design exists; if the coder report lists blocked requirements, send them as feedback to run_requirements at most twice, then stop and report; use ask_human when open questions exist (paused through HumanInTheLoopMiddleware). Resilience: ModelFallbackMiddleware to DIAL_DEPLOYMENT_FALLBACK on the orchestrator; with_retry and with_fallbacks on the chain stages. Per-stage deployments configurable. Cost: one UsageMetadataCallbackHandler across the run; out/run-report.md lists per-stage tokens, wall clock and the sequence of tool calls. CLI: python -m prd_pipeline run <prd-path>. The existing stage CLIs keep working.*

Read `proposal.md`: **Modified Capabilities** must not be empty — Lab 2's checkpoint behavior and Lab 3's exit behavior both change. Open the delta specs: changed requirements belong under `## MODIFIED Requirements` **with the full requirement text**, not a diff. If the proposal put them under ADDED, fix it — a partial MODIFIED loses detail at archive. Apply, verify, archive; at archive, read the sync summary. This is the first time the living specs *change* rather than grow.

Run: `python -m prd_pipeline run prd/notification-policy-prd.md`. Answer the questions. Watch the tool-call sequence.

### Worksheet

| Signal | Fixed pipeline | Orchestrator |
|--------|----------------|--------------|
| Stage call sequence | R → D → C | |
| Backward hops (coder → requirements) | 0 | |
| Tests passing / total | | |
| Blocked requirements at the end | | |
| Tokens per stage, and total | | |
| Wall clock | | |
| Human questions asked | | |

## Part C — Open the hood

1. Specialists as tools: read the orchestrator's tool docstrings. They *are* the org chart. Which would you rewrite after watching the run?
2. **Coordinator** row of Week 2's page — but Week 2's coordinator was Claude Code spawning subagents. This one is your code. What can yours do that Claude Code's can't, and the reverse?
3. Kill the primary: set `DIAL_DEPLOYMENT` to a deployment that doesn't exist, keep the fallback valid, run again. Where in `out/run-report.md` can you see the fallback fire, and what did it cost?
4. Per-stage deployments: cheapest on requirements, strongest on the coder. Re-run. Which stage's quality moved?

## Part D — Drift hunt

Outside OpenSpec, fresh session, ask Claude Code for a small tweak:

> *make the traceability check a warning instead of an error, it's slowing me down*

Let it. Then, in another fresh session:

> *compare the implementation in src/ against every requirement in openspec/specs/. List each requirement no longer satisfied, with file and line.*

Did it find the drift? Revert the tweak (`git checkout -- .`). Then do it properly: a change whose delta spec says MODIFIED, apply, archive — or decide the spec was right and change nothing. Either way spec and code agree again. That agreement is the point of the week.

## Part E — Reflect

Answer in 2–3 sentences each (in class: discuss as a group first):

1. Fixed pipeline vs orchestrator: with your numbers, when does agency pay? Write the rule.
2. Your pipeline has stages, artifacts, a checkpoint and a report. OpenSpec has proposal, specs, design, tasks, verify and archive. What does OpenSpec have that your pipeline lacks — and would you add it?
3. The drift in Part D took one sentence to create. What would catch it without a human asking — a hook, a test, a CI step running the comparison? Sketch one.

## What to submit

- Worksheet + `out/run-report.md` from the orchestrator run
- The delta spec showing MODIFIED requirements, and the archive sync summary
- Part D's drift report and reflections

💡 Lab 5 is optional. If you stop here, you're done: PRD in, tested code out, every stage under a living spec.
