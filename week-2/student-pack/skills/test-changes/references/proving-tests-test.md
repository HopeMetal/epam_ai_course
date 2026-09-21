# Proving that tests test

A test that has never failed proves nothing. It might assert a tautology, mock the system under test out of the loop, or assert whatever the code already does. The only evidence a test tests is watching it fail exactly when the change it guards is absent.

## The stash proof

Strongest evidence: run the new tests **without the implementation** and watch them go red.

**Requires the human's explicit approval before touching the tree — every time.** This manipulates their working tree; approval once for the technique is not approval for each run if anything about the tree changed.

1. From the branch diff, list **implementation files** (changed source) and **new test files**. The split must be exact — a test file in the stash breaks the whole proof.
2. Confirm the tree is otherwise clean (`git status`). If it isn't, stop — do not stash unrelated work.
3. Stash only the implementation:

   ```
   git stash push -- <implementation files>
   ```

4. Run the new tests. **Expected: red**, and red *for the right reason* — read the failure messages; "module not found" everywhere may mean the stash took too much.
5. Restore immediately — this step runs even if step 4 surprised you:

   ```
   git stash pop
   ```

6. Run the new tests again. **Expected: green.**
7. Report both results.

**Abort rules**: stash conflict on pop, unexpected files in the stash, or red-for-the-wrong-reason → restore everything first, verify `git status` matches the pre-stash state, then report. Never debug on a half-stashed tree.

## Interpreting the outcomes

| Red without impl, green with | ✅ The test tests the change |
|------------------------------|------------------------------|
| **Green without impl** | 🚫 The test proves nothing — it asserts something the change didn't introduce. Rewrite it |
| **Red with impl** | The test found a defect, or the test is wrong. Read the failure honestly before deciding which |

## Cheaper proxies

When the stash is too risky (tangled diff, generated files, human declined):

- **Negate one assertion** per test, run, confirm red, restore the assertion. Proves the assert executes and can fail — weaker than the stash (doesn't prove it fails for the *planned* reason), but cheap.
- **Revert one hunk**: `git stash push -- <one file>` for the single file whose behavior the test targets. A miniature stash proof with a smaller blast radius.
- **Review-only proof** (last resort): trace by reading that the asserted value cannot be produced without the change. Say explicitly in the report that the proof was static, not executed.
