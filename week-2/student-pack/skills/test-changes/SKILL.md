---
name: test-changes
description: Write and verify tests for a just-implemented change. Use when asked to add tests for recent changes, a feature branch, or a diff. Reads the plan's test plan and the branch diff, detects the test runner, writes tests, proves each new test fails without the change (with human approval), iterates to green, then runs a fresh-context coverage critic subagent.
compatibility: Designed for Claude Code; requires git and a locally runnable test suite
metadata:
  author: ai-assisted-engineering-labs
  version: "1.0"
---

# Test Changes

Write tests that test **the change**, not the code's current mood. The two failure modes this skill exists to prevent:

- Tests that assert what the code *does* instead of what the plan *required* — if the implementation is subtly wrong, such a test canonizes the bug as a spec.
- Tests that have never been seen red — a test that cannot fail proves nothing.

## Inputs

- **The plan file** under `docs/ai/` — its **Test plan** section is the list of behaviors to prove. If no plan exists, ask the human what behaviors changed; do not reverse-engineer requirements from the implementation.
- **The change**: `git diff <base>...HEAD` (detect the base branch via `git symbolic-ref --short refs/remotes/origin/HEAD`; ask if unknown). This tells you which files are implementation and which are new tests — the stash proof below depends on that split.

## Procedure

1. **Detect the test setup.** Run:

   ```
   bash scripts/detect-test-setup.sh
   ```

   It prints the framework and run command, or exits nonzero — in which case ask the human for the command instead of guessing.

2. **Map behaviors to tests.** Every row of the plan's Test plan gets at least one test. Classify each test you intend to write using the taxonomy in [references/test-quality.md](references/test-quality.md) — and write zero **Invented** tests knowingly: if you catch yourself asserting a rule found in no plan or requirement, that's a question for the human, not a test.

3. **Write the tests**, imitating the repo's existing test conventions — file placement, naming, fixtures, assertion style. Open two neighboring test files first and match them.

4. **Prove the tests test** *(human approval required)*. Follow [references/proving-tests-test.md](references/proving-tests-test.md): with the human's explicit OK, stash the implementation files from the diff (keeping the new test files), run the new tests expecting **red**, restore, run again expecting **green**. If the human declines the stash, use one of the cheaper proxies in the same reference — never skip the proof entirely, silently.

5. **Iterate to green — bounded.** Maximum 3 fix cycles. A test that stays red because it found a real defect in the implementation is a **win**: stop, report the defect, and do not "fix" the test to pass. After 3 cycles on any other failure, stop and report honestly what remains red and why.

6. **Coverage critic** *(fresh-context subagent)*. Spawn one subagent that receives **only**: the plan's Test plan section and the test files — never the implementation, never this conversation. Its prompt:

   > You are auditing test coverage. You have a list of required behaviors and a set of test files — nothing else. Report, in at most 20 lines: **Untested behaviors** (required behaviors no test provably covers); **Suspicious tests** (tests asserting rules that appear in no required behavior — candidates for Invented); **Verdict**: does this suite prove the required behaviors, yes/no/partially, one sentence why.

   The critic sees no implementation on purpose: knowing how the code works biases coverage judgment toward what the code does.

7. **Report**: a table of test → behavior it proves → taxonomy tag → red-proof result, followed by the critic's findings and an honest "what remains untested" line.

## Rules

- Never weaken an assertion to reach green without flagging it as such.
- Never delete or skip an existing failing test to make the suite pass — report it.
- New tests follow the repo's conventions even where this skill's examples differ.
