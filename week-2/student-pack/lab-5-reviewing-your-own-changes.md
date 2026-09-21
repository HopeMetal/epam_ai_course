# Lab 5 — Claude Reviews Its Own Changes

**Works**: pairs recommended (swap findings lists) · **Needs**: the finished branch from labs 3–4

You will make Claude Code review its own branch twice — once inside the conversation that wrote the code, once through fresh subagents that never met the author — and measure the gap. The gap has a name: contamination.

## Scenario

`lab-3-feature` is "done": feature implemented, tests green. Before the PR, you want the AI's own review. The naive way is to ask the session that did the work — which is asking a student to grade their own exam, in pen, for a prize. Today you run both ways and count what each one catches.

## Part A — The contaminated review

Go back to the session that wrote the code (resume it, or re-open it and let it reload its context). Ask:

> *review your changes on this branch and find problems*

Record every finding with its severity. ⚠️ Name the trap before you measure it: this reviewer knows what every line *means to do*, and it already agreed with every decision — it reads intent, not text.

## Part B — The fresh review

```
cp -r skills/self-review <your-repo>/.claude/skills/
```

**Fresh** session:

> *review the changes on this branch before I open a PR*

Watch the choreography: the coordinator collects the diff and the plan's required behaviors, then spawns reviewer subagents that receive **only artifacts** — diff, checklist, severity rubric — never the authoring conversation. Findings without a concrete failure scenario get discarded (listed, so you can veto). The report lands in `docs/ai/review-<branch>.md`.

### Worksheet

| Finding (short) | Severity | Found by: contaminated / fresh / both | Real or false positive? |
|-----------------|----------|---------------------------------------|-------------------------|
|  |  |  |  |

In pairs: swap worksheets and challenge each other's "real or false positive" calls — a finding needs a failure scenario to survive the challenge.

## Part C — Open the hood

1. Find the **isolation rule** in `self-review/SKILL.md` — "reviewers get artifacts, never your reasoning." Why does briefing the reviewer with "context" defeat the skill's whole purpose?
2. This is two rows of `reference-agentic-patterns.md` at once: **Coordinator** (formation choice, dispatch, merge) and **Review and critique** (fresh critic). Trace both in your transcript.
3. Subagents nest **one level**: your reviewers cannot spawn sub-reviewers. What second level would you want (a security specialist per finding? a repro-attempt agent?), and how would you fake it with what you have?

## Part D — Close the loop

Fix the top findings, **one finding per request** — Week 1's rule, still in force: bulk fixes trade a seen defect for an unseen one. After each fix, re-run the skill and check both halves: the finding is gone, *and* nothing new appeared. Stop when no Critical or High remains.

That branch is now genuinely PR-ready — map → plan → implementation → tests → fresh review, every step an artifact in `docs/ai/`. That's the week.

## Part E — Reflect

Answer in 2–3 sentences each (in class: discuss as a group first):

1. How big was the contaminated-vs-fresh gap, and which *kind* of finding did contamination hide most?
2. Which specialist reviewer earned its context cost on your diff — and would you pay for all three on every PR?
3. Capstone: list which of the 12 patterns from `reference-agentic-patterns.md` you actually exercised this week, then write your team's one-sentence rule for when an AI-authored change may merge.

## What to submit

- The merged findings worksheet
- The final `docs/ai/review-<branch>.md` + before/after severity counts from the fix loop
- Your merge rule and reflections
