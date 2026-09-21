# Lab 4 — Tests That Actually Test the Change

**Works**: solo or in pairs · **Needs**: the `lab-3-feature` branch + the plan file

You will get tests for your feature twice — a bare "write tests" run and a skill run that proves each test can fail — then tag every test by what it really proves, hunting for the ones that quietly canonize whatever your code happens to do.

## Scenario

The feature "works". Now the danger inverts: AI-written tests tend to assert what the code *does*, not what the plan *required*. In Week 1 you tagged those **Invented** on a toy story; today they show up in your own repo, wearing your naming conventions.

## Part A — Baseline

On `lab-3-feature`, fresh session:

> *write tests for my recent changes*

Before running anything, note **what it read** — the diff? the plan? just whatever files looked relevant? Then run the tests. Tag every test:

| Tag | Meaning |
|-----|---------|
| **Plan-direct** | Proves a behavior listed in the plan's Test plan |
| **Negative** | Invalid input / error path for a planned behavior |
| **Boundary** | Edge of a range or limit the plan mentions |
| **Beyond-plan** | Useful scenario the plan never listed |
| **Invented** | Asserts a rule found in no plan or requirement — the AI made it up |

## Part B — Install and run the skill

```
cp -r skills/test-changes <your-repo>/.claude/skills/
```

Fresh session:

> *add tests for the changes on this branch, using the plan*

Three moments to watch for:

1. It runs `scripts/detect-test-setup.sh` to find your runner (instead of guessing).
2. **The red-run proof** — it asks your permission to stash the implementation, runs the new tests expecting **red**, restores, reruns expecting **green**. Say yes. A test you've never seen fail has proven nothing.
3. **The coverage critic** — a fresh subagent that sees *only* the plan's test plan and the test files, never the implementation, and reports untested behaviors and suspected Invented tests.

### Worksheet

| Test (short name) | Source: baseline / skill / both | Tag | If Invented: what rule did the AI canonize? |
|-------------------|--------------------------------|-----|---------------------------------------------|
|  |  |  |  |

Tally the tag distribution per run. Where did the **Invented** count move, and why?

## Part C — Open the hood

1. Read `references/proving-tests-test.md`. In one sentence: what does a red run prove that a green run can't? Find the abort rules — why does `git stash pop` run *even when step 4 surprises you*?
2. Find the permission gate in SKILL.md step 4. This is the **Human-in-the-loop** row of `reference-agentic-patterns.md`; the bounded fix cycle in step 5 is the **Loop** row. Why is the loop capped at 3?
3. Run `bash .claude/skills/test-changes/scripts/detect-test-setup.sh` yourself. Did it find your runner? If it exited 1, you've found Part D's assignment.
4. The critic gets a *clean context* on purpose — knowing the implementation biases coverage judgment toward what the code does. Hold that thought: Lab 5 is this idea, scaled up.

## Part D — Extend the skill

Add one category your team actually needs to the taxonomy in `references/test-quality.md` (the "Team categories" comment block shows the shape — concurrency and i18n are common), **and** mirror it in the critic's prompt in SKILL.md step 6. Re-run only the critic step:

> *re-run the coverage critic from the test-changes skill against the current test files*

Did the new category produce a finding the first critic run couldn't have made?

## Part E — Reflect

Answer in 2–3 sentences each (in class: discuss as a group first):

1. Did any baseline test assert current behavior that contradicts the plan? What does that test cost the next developer after it merges?
2. When is the stash proof too expensive, and which cheaper proxy from `proving-tests-test.md` would you adopt as your default?
3. What did the fresh-context critic find that the agent that wrote the tests didn't — and why couldn't it have?

## What to submit

- The tagged worksheet with per-run tallies
- A snippet of the red-run output (the moment your tests failed for the right reason)
- The critic's findings + your added category, and reflections

💡 Keep the branch with its tests — Lab 5 reviews the whole thing.
