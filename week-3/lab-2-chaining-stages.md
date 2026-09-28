# Lab 2 — Chaining Stages

**Works**: solo · **Needs**: `lab-1-requirements` with the requirements stage archived

You will add two stages that both derive from the requirements — architecture and test design — run them in parallel, put a human between stages where the PRD is ambiguous, and let a five-line deterministic check catch the tests the model invented.

## Scenario

Architecture and test design both read the requirements and neither reads the other: a parallel branch. It is also a trap — the test designer will cheerfully cover requirements that don't exist. Week 1 Lab 3 had you tag those **Invented** by hand. Today code does it.

## Part A — The one-shot baseline

Before building anything, ask the model to do it all at once — on the **same deployment** your pipeline uses, or the comparison is unfair. Either paste into the DIAL chat UI with that deployment selected, or write a throwaway five-line script around `get_model().invoke(...)` (you have the factory now). Prompt, followed by the full PRD text:

> *Produce (1) a component architecture and (2) a complete test case list for this PRD. Every test case must cite the requirement ID it covers.*

Save the answer as `out/baseline-one-shot.md`. Read it with a pen. Count test cases; count those citing an ID that exists in `out/requirements.json`; count those covering something no requirement says. Note the tokens if your route shows them.

## Part B — Two stages, one parallel branch, one checkpoint

Branch `lab-2-design` from `lab-1-requirements`. Fresh session:

> */opsx:propose add-architecture-and-test-stages: two stages that consume out/requirements.json. Architecture: components, interfaces, data model, decisions, with every FR/NFR mapped to a component. Test design: test cases with id, title, covers (list of requirement IDs), preconditions, steps, expected; include negative and boundary cases. Run both in parallel with RunnableParallel from the same requirements input. Before either runs, if requirements.open_questions is non-empty, stop and ask the human to answer each on the CLI; record the answers in out/decisions.md and pass them into both prompts. After both finish, a deterministic traceability check fails the run if any test case cites an unknown requirement ID and reports requirements with zero tests. Writes out/architecture.{json,md} and out/test-cases.{json,md}. CLI: python -m prd_pipeline design.*

Before `/opsx:apply`, edit the spec so these exist as scenarios: the stop-and-ask behavior; *unknown requirement ID in a test case → StageError naming the test*; *requirement with no test case → listed in the report*. Then apply, verify, archive as in Lab 1.

Run it: `python -m prd_pipeline design`. It will ask you the PRD's open questions. **You are the product owner now.** Answer decisively; record nothing you didn't decide — Week 1 Lab 2's rule, still in force.

### Worksheet

| Signal | One-shot (Part A) | Staged pipeline |
|--------|-------------------|-----------------|
| Test cases produced | | |
| Cite an existing requirement ID | | |
| Cite a non-existent ID — caught by whom? | | |
| Cover no requirement at all (**Invented**) | | |
| Requirements with zero tests | | |
| Tokens | | |
| Open questions surfaced *before* design started | n/a | |

## Part C — Open the hood

1. Find the `RunnableParallel`. Confirm from timestamps or a log line that both branches ran concurrently. What did each branch receive — the object or the markdown? Why does that matter for tokens?
2. Find the traceability check (a `RunnableLambda` or plain function). This is the **Custom logic** row of Week 2's pattern page: deterministic where determinism is cheap. What would it cost to ask the model to check traceability instead — and would you trust the answer?
3. Find the checkpoint. Which pattern row is it? In a real pipeline, where would this stop surface — CLI, ticket, chat?
4. `.batch`: the test designer could run once per requirement group instead of once overall. Ask Claude Code (same session) what that would change about coverage and cost. Don't build it.

## Part D — Extend: make the check bite

Hand-edit `out/test-cases.json`: change one test's `covers` to `FR-99`. Re-run only the check (add a subcommand or call the function). It must fail, naming the test. Now the real experiment: point the test-design stage at a smaller deployment and re-run `design`. Did the check fire on its own? Count **Invented** cases per deployment.

## Part E — Reflect

Answer in 2–3 sentences each (in class: discuss as a group first):

1. What did the staged pipeline buy over the one-shot — in traceability, in tokens, in your ability to intervene?
2. The checkpoint asked you the PRD's open questions. Compare with your Week 1 Lab 2 worksheet if you kept it. Who found more — you then, or the stage now?
3. Your OpenSpec spec for this change has scenarios. Your test cases for the *product* have scenarios. Same shape, two layers. What does that say about what a spec is?

## What to submit

- Worksheet + `out/decisions.md`
- The traceability failure output from Part D
- Reflections

💡 Keep `out/architecture.json` and `out/test-cases.json` — Lab 3's coder works from them.
