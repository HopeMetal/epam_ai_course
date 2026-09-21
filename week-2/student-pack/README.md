# AI-Assisted Engineering Labs — Week 2 Student Pack

Week 1 taught you to direct AI and distrust it productively, tool-agnostically. Week 2 is **Claude Code specific** and has two themes: **skills** (workflows written down as installable instructions) and **subagents** (fresh contexts you delegate to — and sometimes deliberately don't). You'll run one full delivery loop on your own repository: map it, plan a feature, implement it, test it, and have Claude review its own work with uncontaminated eyes.

## What you need

- **Claude Code** installed and authenticated (you'll work in a terminal)
- **git**, and a repository of your own — choose it with `choosing-your-repo.md` **before Lab 1**
- The `skills/` folder from this pack

## The labs

| # | Lab | You will practice |
|---|-----|-------------------|
| 1 | [Explaining Repository Structure](lab-1-explaining-repo-structure.md) | Skill anatomy, progressive disclosure, parallel explorer subagents |
| 2 | [Planning Before Implementing](lab-2-implementation-planning.md) | Grounded plans, investigation subagents, human checkpoints |
| 3 | [Implementing a Small Feature from a Plan](lab-3-implementing-a-small-feature.md) | Plan-driven execution, deviation logs — and why zero subagents |
| 4 | [Tests That Actually Test the Change](lab-4-implementing-tests.md) | Red-run proofs, the Invented-test hunt, a fresh-context critic |
| 5 | [Claude Reviews Its Own Changes](lab-5-reviewing-your-own-changes.md) | Contamination vs fresh eyes, coordinator + reviewer subagents |

Unlike Week 1, these labs are **strictly sequential** — each consumes the previous lab's artifact (repo map → plan → branch → tests → review). Read `reference-agentic-patterns.md` alongside them; every lab points at the pattern it exercises.

## The skills

Each lab ships a ready-made Agent Skill. You'll install it, baseline against it, open its hood, and extend it.

| Skill | Used in | What it does |
|-------|---------|--------------|
| `repo-map` | Lab 1 | Explains a repo's architecture and writes `docs/ai/repo-map.md` |
| `feature-plan` | Lab 2 | Investigates, interrogates you, writes `docs/ai/plan-<slug>.md` |
| `implement-plan` | Lab 3 | Executes a plan step by verified step, logging every deviation |
| `test-changes` | Lab 4 | Writes tests, proves they can fail, runs a coverage critic |
| `self-review` | Lab 5 | Spawns fresh reviewers that never met the author |

Installing one (from the pack root):

```
mkdir -p <your-repo>/.claude/skills
cp -r skills/<name> <your-repo>/.claude/skills/
```

Every skill follows the [agentskills.io](https://agentskills.io/specification) structure — `SKILL.md` plus `references/`, `scripts/`, `assets/`. Lab 1 Part C walks the anatomy once; after that you're expected to read skills the way you read code.

## Ground rules

1. **One repo, one feature, all week.** The through-line is the point; switching resets everything.
2. **Baseline before skill.** Running the skill first destroys the comparison — this week's version of "don't peek ahead".
3. **Fresh sessions matter.** Contaminated context is Lab 5's villain; don't invite it into labs 1–4 either.
4. **Branches, never your base branch.** Every lab that writes code says so; it's still your job.
5. **Record as you go.** Worksheets filled from memory at the end are fiction.
6. **Your code, your call.** Confirm your org's and client's AI-tooling policy allows this repo before feeding it to any AI tool.
