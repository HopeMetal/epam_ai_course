# Reference — Agentic Design Patterns in Claude Code

## Read the source first

The patterns themselves live here, and this document deliberately does not restate them:

📄 **https://docs.cloud.google.com/architecture/choose-design-pattern-agentic-ai-system**

Read it before Lab 1 Part D. Then use this document for the two things the source can't tell you: which patterns you can actually implement with Claude Code subagents and agent teams, and which pattern fits each of this week's five use cases. Your job across the week is to *implement* the patterns from that page in your own repo — the labs walk you through most of them, and the last section hands you the rest.

## The mapping: pattern → Claude Code

| Pattern (Google's name) | Claude Code construct | Subagents / agent teams? | Best fit this week |
|---|---|---|---|
| Single-agent system | The default Claude Code loop: one context, tools, your prompt | n/a — it's the baseline everything else escalates from | Lab 3 — implementation wants one context that holds the whole change |
| Sequential | Skills chained by artifacts: each produces the file the next consumes | ✅ also as a fixed pipeline of subagents | The week itself — map → plan → implement → test → review |
| Parallel | Several subagents at once, results merged by you | ✅ the canonical use | Lab 1 — one explorer per repo area; Lab 2 — one investigator per unknown |
| Loop | Skill-encoded repeat-until with a hard exit bound | ✅ | Lab 4 — red → green cycles, max 3, then stop and report |
| Review and critique | Generator in one context, critic in a fresh subagent | ✅ the flagship | Lab 5 — reviewers that never see the authoring conversation; previewed by Lab 4's coverage critic |
| Iterative refinement* | Re-run against a quality bar until it passes | ✅ | Lab 5 Part D — fix one finding, re-review, repeat until no Critical/High |
| Coordinator | Main agent decomposes, dispatches to specialists, merges | ✅ | Lab 5 — the review coordinator choosing and merging specialist reviewers |
| Hierarchical task decomposition | Plan mode + one level of specialist subagents | ⚠️ one level only — Claude Code subagents cannot spawn subagents | Lab 2 — feature → unknowns → parallel investigations |
| Swarm | Agent teams (experimental): peer agents with a shared task list, messaging each other | ⚠️ partial — peers exist, but all-to-all iterative handoff is limited | None this week; closest is Lab 5's three parallel specialists |
| ReAct | The default loop again — every tool call is act, every result read is observe | inherent | Lab 3 — each step's verify-by is an explicit observation step |
| Human-in-the-loop | Plan mode, permission prompts, and skill-mandated checkpoints | orthogonal — combines with any of the above | Lab 2 — plan confirmation twice; Lab 4 — approval before the stash proof |
| Custom logic | Hooks, and deterministic `scripts/` inside skills | partly — the logic is code, agents call it | Labs 1 & 4 — `scan_repo.sh`, `detect-test-setup.sh`: deterministic where determinism is cheap |

\* Google's page lists Iterative refinement under both its deterministic and iteration-based groups; it appears once here.

## What each lab teaches, in pattern terms

| Lab | Pattern(s) you exercise |
|---|---|
| 1 — Repo structure | Parallel (explorer fan-out), Custom logic (the scan script) |
| 2 — Planning | Hierarchical decomposition (one level), Parallel (investigators), Human-in-the-loop (two checkpoints) |
| 3 — Implementing | Single-agent / ReAct — **deliberately zero subagents**; the contrast with labs 1–2 is the lesson |
| 4 — Tests | Loop (bounded red→green), Review and critique (coverage critic), Human-in-the-loop (stash approval) |
| 5 — Self-review | Coordinator + Review and critique (flagship), Iterative refinement (the fix loop) |

## Honest limits

- **One level of nesting.** Subagents cannot spawn subagents. Any hierarchy deeper than coordinator → specialists must be flattened or run as separate sessions.
- **Every subagent is a fresh context.** It re-reads, re-orients, and re-costs tokens. Parallel is for work that is genuinely independent, not for making progress bars move.
- **Continuity is a resource too.** Lab 3 exists to show the case where *not* delegating wins. If you can't say what a subagent buys you, don't spawn it.
- **Agent teams are experimental.** Treat Swarm as a pattern to understand, not yet a pattern to bet a delivery on.

## Try one yourself

After Lab 5, pick a pattern the week didn't implement and build it from the source doc:

- **Swarm**: sketch (on paper, or as an experiment with agent teams) three peer agents debating a design decision from your repo — what stops them converging?
- **Custom logic via hooks**: a hook that blocks any commit touching files outside the current plan's file list — Lab 3's stop condition, enforced by code instead of prompt.

Either one makes a good sixth skill. You now know the directory structure by heart.
