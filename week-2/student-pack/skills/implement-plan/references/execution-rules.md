# Execution rules

## One step at a time

Implement step N completely — change, verify, commit — before reading step N+1's details. Implementing ahead "because it's obvious" is how plans and branches quietly diverge: the diff stops matching the contract, and the review at the end can't tell intent from accident.

## Verify-by is not optional

A step without a passing verify-by is not done; it is typed. If a verify-by turns out to be unrunnable (wrong command, missing tool), that's a deviation — amend the plan, don't skip the check.

## Commit per step

Small commits give you two things: a revert point per step, and a commit log that reads as the plan's execution trace. If a step turns out wrong in Lab-style review later, one `git revert` removes exactly it.

## Why this skill spawns no subagents

This is a deliberate design decision, and the reasoning matters more than the rule:

- **Context continuity is the implementer's asset.** By mid-plan, your context holds things no file records: how you interpreted ambiguous steps, the quirk you found in the config loader, the half-decision about naming you'll resolve in step 5. A fresh subagent gets none of that. Handing it step 4 discards exactly the knowledge that makes step 4 safe.
- **Delegation buys parallelism and costs continuity.** Investigation (the `feature-plan` skill) wants parallelism: independent questions, no shared state. Review (the `self-review` skill) wants the *opposite* of continuity: fresh eyes, no author bias. Implementation of one small feature is the case in between where continuity wins outright — the steps share state by design.
- **A small feature has no parallel structure anyway.** Steps depend on each other's edits. Parallel subagents on sequential steps just adds merge conflicts with yourself.

When a change genuinely decomposes into independent parts (two features, refactor + feature), that's not one plan — it's two plans, implemented one after the other or by two sessions. Split the plan; don't split the implementer.

## Scope discipline, restated

The moment you type code the plan doesn't mention, one of two things is true: the plan is wrong (deviation protocol — amend it in writing) or you're scope-creeping (stop). There is no third state.
