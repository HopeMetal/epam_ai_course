# Lab 2 — Planning Before Implementing

**Works**: solo or in pairs · **Needs**: Lab 1's `docs/ai/repo-map.md`

You will plan the same feature twice — once with a bare prompt, once with a planning skill that investigates in parallel and interrogates *you* — then measure which plan could actually be executed by someone who wasn't in the room.

## Scenario

Pick the feature that powers the rest of your week. It must: touch roughly 2–5 files, need no schema migration, and fit in two sentences. If nothing in your backlog fits, use an archetype: a new CLI/config flag, a new validation rule, a variant of an existing command or endpoint, structured logging around one operation.

⚠️ **Choose carefully — this feature is your material for labs 2, 3, 4, and 5.**

## Part A — Baseline

Fresh session, minimal prompt:

> *make an implementation plan for <your feature, two sentences>*

Save the plan. Count: how many steps name **real files or symbols from your repo**, and how many are generic ("update the service layer", "add appropriate tests")? Generic plans read fine — that's the trap. They ground nothing and could have been written without ever seeing your repo.

## Part B — Install and run the skill

```
cp -r skills/feature-plan <your-repo>/.claude/skills/
```

Fresh session, same two-sentence feature. Expect the skill to behave differently than the baseline did: it restates the feature and **waits for your confirmation**, spawns one investigation subagent per unknown, then brings the open questions and risky decisions **back to you** before writing `docs/ai/plan-<slug>.md`.

### Worksheet

| Criterion (0–3 each)                    | Baseline plan | Skill plan | Evidence |
| --------------------------------------- | ------------- | ---------- | -------- |
| Grounding — steps name real paths       | 3             | 3          |          |
| Verifiable — every step has a verify-by | 0             | 3          |          |
| Risks & unknowns made explicit          | 0             | 3          |          |
| Test plan names behaviors               | 3             | 3          |          |
| Out of scope stated                     | 0             | 3          |          |

Confirm if initial examination of feature is correct.
List of decisions to verify assumptions or suggest a different approach.
Asking if the modified decisions are correct before writing plan.

Below the table, list every question the skill asked **you**. That list is the plan's real output — the baseline asked you nothing.

## Part C — Open the hood

1. **Template anatomy**: open `feature-plan/assets/plan-template.md`. Why do "Out of scope", "Open questions", and an *empty* "Deviation log" exist? (The Deviation log gets written in Lab 3 — remember it's here.)
2. **The two human checkpoints**: find both in SKILL.md. Map them to the **Human-in-the-loop** row of `reference-agentic-patterns.md`. What would silently break if checkpoint 1 were removed?
3. **Investigator prompts**: find one investigation subagent's prompt in your transcript. Check it against `references/investigation-subagents.md`: one question, fixed return format, "Not checked" line. Did the investigator's evidence hold up when you spot-check one file:line claim?

## Part D — Extend the skill

Add one section your team actually needs to `assets/plan-template.md` — "Rollback strategy" and "Feature flag" are common candidates — plus the one matching instruction line in SKILL.md step 5 so the agent fills it. Fresh session, re-run the planning step, and confirm your section appears in the regenerated plan.

This is the whole skill-maintenance loop: template + instruction + re-run. No code.

## Part E — Reflect

Answer in 2–3 sentences each (in class: discuss as a group first):

1. Which question the skill asked would otherwise have ambushed you mid-implementation — and what would the interruption have cost?
2. Where does the human checkpoint belong: before investigation, after, or both? Argue from what you saw, not from principle.
3. Finish the rule of thumb: "For my repo, planning pays for itself when a change is bigger than …"

## What to submit

- Both plans (baseline and `docs/ai/plan-<slug>.md`)
- The worksheet + the list of questions the skill asked you
- Your template extension (paste the diff) and reflections

💡 Keep the plan file on the repo — Lab 3 executes it, and its Deviation log is about to earn its keep.
