# Reference — The Spec-Driven Loop (OpenSpec)

## Read the source first

📄 **https://github.com/Fission-AI/OpenSpec** — README, `docs/getting-started.md`, `docs/commands.md`. This document does not restate them. It tells you which command each lab uses, the formatting rules that fail silently, how the loop maps onto the pipeline you're building, and what changed since Week 2's plan files.

Verified against OpenSpec **1.3.1** with `openspec init --tools claude`, which installs eleven `/opsx:*` commands into `.claude/commands/opsx/` and matching skills into `.claude/skills/`.

## The loop

```
/opsx:explore  ──►  /opsx:propose  ──►  (you edit the artifacts)  ──►  /opsx:apply  ──►  /opsx:verify  ──►  /opsx:archive
   think            change folder +        the human checkpoint         code, tasks        report:           specs merged,
                    4 artifacts                                         checked off        CRITICAL /        change filed
                                                                                           WARNING           under archive/
```

| Command | What it does | Lab |
|---------|--------------|-----|
| `/opsx:explore <question>` | Thinking partner; reads the codebase and specs; writes nothing | 4 (before a brownfield change) |
| `/opsx:propose <name>: <description>` | Creates `openspec/changes/<name>/` and generates proposal → specs → design → tasks in one go | 1–5 |
| `/opsx:new`, `/opsx:continue`, `/opsx:ff` | The same, one artifact at a time (`continue`) or all at once (`ff`) — use when you want to review each artifact before the next is generated | optional anywhere |
| `/opsx:apply` | Implements `tasks.md`, checking off `- [ ]` items as it goes | 1–5 |
| `/opsx:verify <name>` | Compares implementation to tasks, specs and design; reports CRITICAL / WARNING / SUGGESTION | 1–5 |
| `/opsx:archive <name>` | Offers to sync delta specs into `openspec/specs/`, then moves the change to `openspec/changes/archive/YYYY-MM-DD-<name>/` | 1–5 |
| `/opsx:sync` | Merge delta specs without archiving | if you need specs updated mid-change |

CLI you will type yourself:

```
openspec init --tools claude                 # once, Lab 1 Part B
openspec validate <change> --strict          # before every apply
openspec status --change <change>            # which artifacts exist / are blocked
openspec list                                # active changes;  openspec list --specs  for living specs
openspec show <change> --json --deltas-only  # what the archive will merge
```

## The artifacts, and the rules that fail silently

```
openspec/
  config.yaml                       the constitution: schema, context, per-artifact rules
  specs/<capability>/spec.md        living truth — only archive/sync writes here
  changes/<name>/
    .openspec.yaml                  schema + created date
    proposal.md                     Why · What Changes · Capabilities (New / Modified) · Impact
    specs/<capability>/spec.md      DELTA: ## ADDED / MODIFIED / REMOVED / RENAMED Requirements
    design.md                       Context · Goals / Non-Goals · Decisions · Risks / Trade-offs
    tasks.md                        ## 1. Group  /  - [ ] 1.1 task
  changes/archive/YYYY-MM-DD-<name>/
```

Delta spec format — the validator is strict about shape and quiet about mistakes:

```markdown
## ADDED Requirements

### Requirement: Test cases trace to requirements
Every test case SHALL list at least one existing requirement ID in `covers`.

#### Scenario: Unknown ID
- **WHEN** a test case cites an ID not present in requirements.json
- **THEN** the design stage raises StageError naming the test case
```

- `### Requirement:` — three hashtags; normative **SHALL/MUST**, not *should*.
- `#### Scenario:` — **four hashtags exactly**. Three, or a bullet, and the scenario is silently dropped. Every requirement needs at least one.
- `## MODIFIED Requirements` — paste the **entire** existing requirement block and edit it. A partial MODIFIED loses the omitted text at archive time.
- `## REMOVED Requirements` — needs **Reason** and **Migration**.
- `tasks.md` — only `- [ ] X.Y` lines are tracked; anything else isn't a task to `/opsx:apply`.

`config.yaml` (Lab 1 Part B gives you a starting point):

```yaml
schema: spec-driven
context: |
  free text — stack, layout, forbidden APIs, the stage contract. Injected into every artifact's generation.
rules:
  proposal: ["quoted strings — one rule per line"]
  specs:    ["…"]
  design:   ["…"]
  tasks:    ["…"]
```

Rule strings must be quoted if they contain a colon, or YAML reads them as a mapping and the rules vanish with a warning you'll never see. `context` and `rules` are constraints on generation; they must not be copied into artifacts.

## Two loops, one shape

| Your pipeline (what you build) | OpenSpec (how you build it) |
|---|---|
| PRD | the idea you give `/opsx:propose` |
| requirements stage → `out/requirements.json` | `proposal.md` + delta `specs/` — WHAT, with IDs |
| architecture stage → `out/architecture.json` | `design.md` — HOW, with decisions and risks |
| test cases → `covers: [FR-n]` | `#### Scenario:` blocks — every scenario "is a potential test case" (OpenSpec's own words) |
| coder agent, bounded, tests read-only | `/opsx:apply`, tasks checked off, tests as verification commands |
| judge stage (Lab 5) | `/opsx:verify` |
| `out/decisions.md` from the human checkpoint | you editing artifacts before apply |
| — | `/opsx:archive`: the delta becomes the living spec |

The last row is the one to think about in Lab 4 Part E. Your pipeline produces artifacts; OpenSpec produces artifacts *and then merges them into a document that stays true*. That merge is what makes a spec different from a plan.

## Spec vs plan — what changed since Week 2

Week 2's `docs/ai/plan-<slug>.md` was a **contract for one change**: written, executed, amended in a deviation log, then history. OpenSpec's `openspec/specs/` is a **description of the system that outlives changes**. A change carries only a *delta*; archiving merges the delta. So:

- After Lab 1, `specs/` says what the requirements stage does.
- After Lab 4, `specs/` says something *different* about the checkpoint and the coder's exit — because Lab 4's delta used MODIFIED.
- Anyone (or any agent) can compare `src/` to `specs/` at any time. Lab 4 Part D does exactly that and finds the drift a "small tweak" created.

Nothing enforces the comparison. That is the same lesson as Week 2 Lab 1 Part C: promised, not enforced, until you add code — a hook, a CI job — that runs it.

## Honest limits

- **`/opsx:propose` is the fast path.** It generates all four artifacts before you see any. When a change is large or brownfield, `/opsx:new` + `/opsx:continue` lets you correct the proposal before the spec is derived from it.
- **`/opsx:verify` is heuristic.** It searches the code for evidence of each requirement; it will miss things and flag things. Treat WARNING as a question, not a verdict.
- **Archive doesn't block.** It warns about unchecked tasks and lets you proceed. Don't.
- **Non-interactive `init` skips `config.yaml`.** You write it. Lab 1 makes that a feature.
- **Slash commands load at startup.** After `openspec init`, restart Claude Code.
