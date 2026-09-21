---
name: implement-plan
description: Execute an existing implementation plan step by step with verification after each step. Use when a plan file exists under docs/ai/ and the user asks to implement, build, or execute it. Enforces a branch and clean-tree preflight, records every divergence in the plan's Deviation log, and stops at defined stop conditions instead of improvising.
compatibility: Designed for Claude Code; requires git
metadata:
  author: ai-assisted-engineering-labs
  version: "1.0"
---

# Implement Plan

Execute a plan produced by the `feature-plan` skill (or any plan with the same shape: grounded steps, verify-bys, a Deviation log). The plan is a **contract**: you follow it, verify each step, and when reality disagrees with it, you amend it in writing — you never silently drift.

This skill deliberately spawns **no subagents**. The implementer's context is the asset: [references/execution-rules.md](references/execution-rules.md) explains why.

## Preflight — all must pass, or stop and ask

1. **Plan identified and read in full.** If several plans exist under `docs/ai/`, ask which one. If its Open questions section still has unanswered items, surface them before writing any code.
2. **On a working branch.** Detect the base branch (`git symbolic-ref --short refs/remotes/origin/HEAD`; ask if unknown). If currently on the base branch, create a branch — never implement on it directly.
3. **Clean working tree.** Uncommitted changes contaminate the diff every later step (tests, review) depends on.
4. **Baseline is green.** Run the test suite once before changing anything. If it's already red, stop and report — you cannot verify steps against a broken baseline.

## Execution loop

For each step in the plan, in order:

1. Restate the step in one line.
2. Make **only** that step's change, in that step's files.
3. Run the step's **verify-by** and show its result.
4. Commit, message referencing the step (e.g. `plan step 3: add expiry check to validator`). Small commits keep every step revertable.

When a step's reality diverges from the plan — a file isn't where the plan says, an approach can't work, something unlisted must change — follow the deviation protocol in [references/when-stuck.md](references/when-stuck.md). Its core: **stop, propose an amendment, get approval, record it in the plan's Deviation log, then continue.**

## Stop conditions — stop and ask, never improvise

- A step requires touching a file **not in the plan's file list**.
- A verify-by **fails twice** after honest attempts.
- You hit anything **security-sensitive** the plan didn't mention: credentials, authz logic, crypto, PII handling.
- The plan's **Current state section turns out to be wrong** — the plan was built on a misreading; patching it heroically step by step produces a haunted branch. Go back to `feature-plan`.

## Finish

1. Run the **full test suite** — not just the steps' verify-bys.
2. Report a summary table: plan step → done/amended/skipped(approved) → verify-by result.
3. Count the Deviation log entries. Zero deviations on a non-trivial change is suspicious — say so if the log looks too clean.
4. Point at what's next: tests for the change (`test-changes` skill), then review (`self-review` skill).

## Scope discipline

Improvement ideas you notice along the way (refactors, cleanups, "while we're here") go into a **Noticed, not done** list in your final report. They never enter the branch. That list is future planning input, not current work.
