# Lab 1 — Explaining Repository Structure

**Works**: solo · **Needs**: Claude Code + your chosen repo (see `choosing-your-repo.md`)

You will make Claude Code explain a repository twice — once bare, once through a skill — score both explanations with the same rubric, then open the skill and see exactly which written instruction bought each point of improvement.

## Scenario

Pretend it's day one on the team that owns this repo. You need the map: not a directory listing, but *where does a change of kind X go, and what do I imitate when I make it*. Everything you build this week sits on top of this map.

## Part A — Baseline

Open a **fresh** Claude Code session in your repo's root and ask, exactly:

> *explain this repository's structure*

Save the answer. Score it with the rubric:

| Criterion (0–3 each)          | 0 looks like                 | 3 looks like                                     |
| ----------------------------- | ---------------------------- | ------------------------------------------------ |
| Entry points                  | Not mentioned                | Every way execution starts, with file paths      |
| Layering & boundaries         | Directory names restated     | Dependency direction, with evidence files        |
| Where tests live              | Not mentioned                | Location, naming pattern, how to run them        |
| "Where would I add feature X" | Unanswerable from the answer | A concrete location + an example file to imitate |
| Build / run / test commands   | Guessed or absent            | Real commands, sourced from manifests or CI      |

⚠️ Baseline answers tend to be a prose `ls` — the directory names, restated confidently. Score what the answer would let a new teammate *do*, not how fluent it sounds.

## Part B — Install and run the skill

Install `repo-map` from this pack into your repo (this is the ritual for all five labs):

```
mkdir -p <your-repo>/.claude/skills
cp -r skills/repo-map <your-repo>/.claude/skills/
```

In a **fresh** session, ask the same question, then let the skill run. It will write `docs/ai/repo-map.md`. Score that file with the same rubric.

### Worksheet

| Criterion                     | Baseline /3 | Skill /3 | What the skill did differently                                                              |
| ----------------------------- | ----------- | -------- | ------------------------------------------------------------------------------------------- |
| Entry points                  | 0           | 1        | Provided a place where primary interaction with the library can happen                      |
| Layering & boundaries         | 1           | 3        | Provided a complete graph of the library's structure                                        |
| Where tests live              | 1           | 2        | Only specified where tests live and how to run them, but nothing about naming patterns      |
| "Where would I add feature X" | 1           | 3        | Provided a table of example features, where to add them and what files to use as an example |
| Build / run / test commands   | 0           | 3        | Provides full table of build / run / test commands with sources of truth                    |

## Part C — Open the hood

Read `.claude/skills/repo-map/SKILL.md` end to end, then answer in your notes:

1. **Frontmatter**: identify each field (`name`, `description`, `compatibility`, `metadata`, `allowed-tools`) and what it's for. Why does the `description` list trigger phrases like "explain repository structure"?
2. **Progressive disclosure**: from your session transcript, which files did the agent actually load, and when? (`references/large-repos.md` should load only for big repos; the template only at writing time.)
3. **The script**: run `bash .claude/skills/repo-map/scripts/scan_repo.sh` yourself. Compare its output to what the agent cited. Why is this a script instead of prompt instructions?
4. **`allowed-tools` tension**: the field grants `Write` to an "explainer" skill. Find the sentence in SKILL.md that constrains it. Is that constraint enforced, or promised? (Answer: promised — the field is experimental and coarse. Worth knowing exactly where prompt ends and enforcement begins.)

## Part D — Parallel explorers

Force the large-repo path even if your repo is medium-sized. Fresh session:

> *map this repository again, but follow the parallel explorer protocol in the repo-map skill's large-repos reference, with 3 explorers*

Watch the subagents fan out — one per area, each returning the fixed report format. Compare the merged map to Part B's:

- Where is the parallel map **deeper**?
- What **cross-cutting** insight (shared libs, config layering, event flows) survived only because of the final merge pass — or didn't survive at all?

📄 This is the **Parallel** row of `reference-agentic-patterns.md`. Read the row and its "Honest limits" section now, while your own evidence is fresh.

## Part E — Reflect

Answer in 2–3 sentences each (in class: discuss as a group first):

1. Which rubric criterion improved most from baseline to skill — and which specific SKILL.md instruction caused it?
2. What did the parallel run buy, and what did it lose? Would you use it on this repo again?
3. What would you add to `references/what-to-look-for.md` for your stack that the skill doesn't know yet?

## What to submit

- The completed worksheet
- Your generated `docs/ai/repo-map.md`
- Reflection answers

💡 Keep `docs/ai/repo-map.md` in the repo — Lab 2's planning skill reads it.
