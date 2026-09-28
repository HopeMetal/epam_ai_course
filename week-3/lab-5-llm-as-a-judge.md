# Lab 5 — LLM-as-a-Judge *(optional)*

**Works**: pairs recommended (score independently, then compare) · **Needs**: labs 1–4 outputs, and `DIAL_DEPLOYMENT_JUDGE` in `.env` — a deployment different from the generator's

You will build a judge stage that scores every artifact against a rubric, then find out whether it agrees with you, whether it agrees with itself on another vendor, and what it costs to be told what you could have seen.

## Scenario

You've been eyeballing `out/*.md` all week. A judge stage turns that into a number with evidence — and inherits every problem Week 2 Lab 5 warned about: a judge that shares the author's context grades intent, not text. So the judge sees artifacts, never prompts, and runs on a deployment other than the one that wrote them.

## Part A — You first

Before any code exists, score two artifacts yourself, 0–3 per criterion:

| Artifact | Criterion | Your score | Evidence |
|----------|-----------|------------|----------|
| requirements | Every PRD statement captured (completeness) | | |
| requirements | No requirement invented (fidelity) | | |
| requirements | Open questions name the real contradictions | | |
| test cases | Every FR has ≥1 test (coverage) | | |
| test cases | Negative and boundary cases present | | |
| test cases | No **Invented** test | | |

## Part B — The judge stage

Branch `lab-5-judge` from `lab-4-orchestrator`. Fresh session:

> */opsx:propose add-judge-stage: a judge stage that scores artifacts. Input: an artifact name and its rubric (criteria with 0–3 anchors). The judge is a structured-output chain on DIAL_DEPLOYMENT_JUDGE. It receives the artifact plus its source of truth — the PRD for requirements, the requirements for test cases — and never any pipeline prompt. Output Verdict: per-criterion score, verbatim evidence quotes, one-line fix. Threshold configurable; below it, the run report flags the artifact. CLI: python -m prd_pipeline judge <artifact>. The orchestrator may call it but must not act on a verdict without ask_human.*

Spec scenarios to insist on: *judge deployment equals generator deployment → refuse to run*; *an evidence quote not found verbatim in the artifact → that criterion's score is marked invalid*. Apply, verify, archive. Run it on both artifacts.

### Worksheet

| Criterion | You | Judge — deployment A | Judge — deployment B | Who's right, and how do you know? |
|-----------|-----|----------------------|----------------------|-----------------------------------|
| | | | | |

## Part C — Calibrate

1. Agreement rate with your Part A scores. Where you disagree, reread the artifact: who was wrong?
2. Switch `DIAL_DEPLOYMENT_JUDGE` to another vendor and re-run. Same verdict? Which criterion moves most — completeness or fidelity?
3. Damage a copy of the requirements artifact (delete two FRs) and judge it. Did completeness drop, and did the evidence quote the missing PRD text?
4. Reverse the order of test cases in the artifact. Does the score move? It shouldn't.

## Part D — Reflect

Answer in 2–3 sentences each (in class: discuss as a group first):

1. When would you *gate* a pipeline on this judge, and when only *report*?
2. What did the judge cost relative to the stage it judged?
3. The evidence-quote check is deterministic; the score is not. If you could keep only one half, which?

## What to submit

- Both worksheets and `out/judge-*.md`
- The damaged-artifact run
- Reflections
