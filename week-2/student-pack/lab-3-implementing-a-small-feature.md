# Lab 3 — Implementing a Small Feature from a Plan

**Works**: solo · **Needs**: Lab 2's `docs/ai/plan-<slug>.md` · work on branches, never your base branch

You will implement the same feature twice — once from just its description, once from your plan through a skill that verifies every step — and let the two diffs argue about which approach you'd want in your repo's history.

## Scenario

The plan from Lab 2 is a contract. Today you find out what contracts are worth when they meet your actual codebase: two runs, two branches, one diff-off.

## Part A — The planless baseline

Create a branch `lab-3-baseline`. Fresh session. Give Claude **only the two-sentence feature description — not the plan**:

> *implement <your feature, two sentences>*

Let it finish. Record in the worksheet: which files it touched, what it added that nobody asked for, whether it ran anything to verify itself, what questions it asked you. Then return to your base branch and keep `lab-3-baseline` for the diff-off.

💡 Short on time? Skip Part A and compare against the *baseline plan* evidence from Lab 2 instead. But the diff-off is the best part of this lab.

## Part B — The plan-driven run

Create a branch `lab-3-feature`. Install and run the skill:

```
cp -r skills/implement-plan <your-repo>/.claude/skills/
```

> *implement the plan in docs/ai/plan-\<slug>.md*

Expect: a preflight (branch, clean tree, baseline test run), then step-by-step execution — each step verified and committed. If reality disagrees with the plan, the skill must **stop, propose an amendment, and write it into the plan's Deviation log** after your approval. That log entry is the artifact to watch for.

### Worksheet

| Signal                                | Planless run                                                                                                                                                                                                                                                                             | Plan-driven run                                                                                                                                                                                                      |
| ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Files touched vs plan's file list     | src/System.CommandLine/Parsing/JsonArgumentPreprocessor.cs, **src/System.CommandLine/ParserConfiguration.cs**, src/System.CommandLine/Parsing/CommandLineParser.cs,  Directory.Packages.props + System.CommandLine.csproj, src/System.CommandLine.Tests/JsonArgumentPreprocessorTests.cs | JsonArgsPreprocessor.cs (new),  System.CommandLine.csproj, Directory.Packages.props, CommandLineParser.cs, ParserTests.JsonInput.cs (new)                                                                            |
| Scope creep (things nobody asked for) | Tests were added which was not asked for in the original feature prompt.                                                                                                                                                                                                                 | None                                                                                                                                                                                                                 |
| Verification commands actually run    | `dotnet build`, `dotnet test`                                                                                                                                                                                                                                                            | `dotnet build`, `dotnet test`                                                                                                                                                                                        |
| Questions it asked you                | None                                                                                                                                                                                                                                                                                     | Asked about open questions in the plan                                                                                                                                                                               |
| Deviations recorded in writing        | None                                                                                                                                                                                                                                                                                     | Recorded the discrepancies between assumptions in the plan and user decisions. Recorded the actual place for package management different from the plan. Recorded the requirement for Step 2 in Step 1 out-of-order. |

Then the diff-off — run both and paste the stats:

```
git diff <base>..lab-3-baseline --stat

 .claude/skills/implement-plan/SKILL.md             |  50 ------
 .../implement-plan/references/execution-rules.md   |  27 ---
 .../skills/implement-plan/references/when-stuck.md |  32 ----
 Directory.Packages.props                           |   1 +
 .../JsonArgumentPreprocessorTests.cs               | 199 +++++++++++++++++++++
 src/System.CommandLine/ParserConfiguration.cs      |  18 ++
 .../Parsing/CommandLineParser.cs                   |   5 +
 .../Parsing/JsonArgumentPreprocessor.cs            | 110 ++++++++++++
 src/System.CommandLine/System.CommandLine.csproj   |   1 +
 9 files changed, 334 insertions(+), 109 deletions(-)

git diff <base>..lab-3-feature --stat

 Directory.Packages.props                           |   1 +
 docs/ai/plan-json-args-input.md                    |   9 +-
 .../ParserTests.JsonInput.cs                       | 130 +++++++++++++++++
 .../Parsing/CommandLineParser.cs                   |  11 ++
 .../Parsing/JsonArgsPreprocessor.cs                | 158 +++++++++++++++++++++
 src/System.CommandLine/System.CommandLine.csproj   |   1 +
 6 files changed, 306 insertions(+), 4 deletions(-)

```

## Part C — Open the hood

1. This is the one skill in the pack that spawns **no subagents — on purpose**. Read `references/execution-rules.md`, section "Why this skill spawns no subagents". Restate the continuity argument in one sentence of your own.
2. Map it to the **Single-agent** and **ReAct** rows of `reference-agentic-patterns.md` — every verify-by is the "observe" step made explicit.
3. Read `references/when-stuck.md`. The deviation protocol's claim: *plans are contracts amended in writing, never silently abandoned.* Check your own Deviation log — is it honest? Zero entries on a non-trivial change deserves suspicion.

## Part D — Extend the skill, then trip your own wire

Add one stop condition to `implement-plan/SKILL.md`'s "Stop conditions" list:

> - The change would modify a file matching `<pattern your team protects>` (e.g. `**/migrations/**`, `**/*.generated.*`).

Then re-run the last plan step (or ask for a tiny in-scope tweak) and, mid-run, request a small addition that violates your new condition. Watch whether the skill stops and asks. You just live-tested a guardrail you wrote — remember from Lab 1 Part C that it's promised, not enforced. How much do you trust it now, and what would enforcement (a hook) add?

## Part E — Reflect

Answer in 2–3 sentences each (in class: discuss as a group first):

1. Where did reality diverge from the plan, and does the Deviation log tell that story truthfully?
2. Would a coordinator-with-subagents setup have implemented this better or worse than one continuous context? Argue from the `reference-agentic-patterns.md` rows, using today's evidence.
3. Write your merge bar: what must be true of `lab-3-feature` before you'd open a PR? Keep it — labs 4 and 5 are how you'll get there.

## What to submit

- The worksheet + both `--stat` outputs
- The Deviation log section of your plan (even if empty — say why)
- Your new stop condition + what happened when you tripped it, and reflections

💡 Keep `lab-3-feature` — labs 4 and 5 build on it. Delete `lab-3-baseline` after the diff-off.
