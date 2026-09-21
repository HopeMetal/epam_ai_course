---
name: self-review
description: Review a branch's changes with fresh, uncontaminated eyes before opening a PR. Use when asked to review changes, self-review work, or check a branch before a PR. Collects the diff, spawns fresh reviewer subagents that never see the authoring conversation, applies a severity rubric with mandatory failure scenarios, and writes docs/ai/review-<branch>.md.
compatibility: Designed for Claude Code; requires git
metadata:
  author: ai-assisted-engineering-labs
  version: "1.0"
---

# Self Review

The context that wrote the code cannot fairly judge it. It knows what every line *means to do*, so it reads intent instead of text; it already decided the approach was right, so it defends instead of probes. This skill routes around that bias with one rule:

**The isolation rule: reviewers get artifacts, never your reasoning.** Each reviewer is a fresh subagent that receives the diff, the checklist, the rubric, and the plan's required behaviors — and nothing from the conversation that authored the code. No summaries, no "context", no explanation of why the approach is fine. If you feel the urge to brief the reviewer, that urge is the bias this skill exists to contain.

## Procedure

1. **Collect the artifacts.**
   - Base branch: `git symbolic-ref --short refs/remotes/origin/HEAD` (ask if unknown).
   - The change: `git diff <base>...HEAD` and `git diff <base>...HEAD --stat`.
   - Required behaviors: the **Feature** and **Test plan** sections of the plan file under `docs/ai/`, if one exists.

2. **Choose the formation.**
   - Default: **one generalist reviewer**.
   - Escalate to **three parallel specialists** when the diff exceeds ~400 changed lines, or touches anything security-sensitive (authn/authz, credentials, crypto, money, PII): *correctness & security* · *tests & coverage* · *maintainability & conventions*.

3. **Spawn the reviewers.** Each gets this prompt, verbatim, with the artifacts pasted in — never linked to your session:

   > You are reviewing a change you did not write. You have: a diff, a review checklist, a severity rubric, and the change's required behaviors. You have no access to the author or their reasoning — judge only what is in front of you.
   >
   > <specialist line, if any: "Focus exclusively on: correctness & security" / "tests & coverage" / "maintainability & conventions">
   >
   > Report each finding as: **file:line · category (per the checklist) · severity (per the rubric) · concrete failure scenario ("with input X, Y happens") · suggested fix (one line)**. A finding without a concrete failure scenario does not count — do not report feelings.
   >
   > End with: **Not assessable from the diff alone** — what you would need the full repo or a runtime to judge.

   Paste [references/review-checklist.md](references/review-checklist.md) and [references/severity-rubric.md](references/severity-rubric.md) into the prompt.

4. **Merge.** Deduplicate findings (keep the highest severity of any duplicate). **Discard every finding without a concrete failure scenario** — but list the discards in the report as false-positive candidates, so the human can veto the discard. Sort by severity.

5. **Verdict.** `blocked` if any Critical stands · `needs-work` for High/Medium findings worth fixing pre-PR · `merge-ready` otherwise. One sentence of justification.

6. **Write the report**: `docs/ai/review-<branch>.md`, using the exact structure of [assets/review-report-template.md](assets/review-report-template.md).

7. **Offer the fix loop.** Fix **one finding per request**, highest severity first — never "fix everything" (bulk fixes trade one defect for another unseen). After fixes, re-run this skill from step 1: the re-review must confirm the finding is gone *and* no new findings appeared. Done when no Critical or High remains.

## Limits — put these in the report, not under the rug

- Reviewers see the diff, not the whole repo: cross-file effects outside the diff land in "Not assessable", and a human must chase them.
- Subagents nest one level: your reviewers cannot spawn sub-reviewers, so the coordinator (you) is the only merge point.
- A clean report is not proof of a good change — it is absence of findings from three narrow readers. Say what was *not* reviewed.
