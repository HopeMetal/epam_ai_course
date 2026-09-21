# When reality disagrees with the plan

## The deviation protocol

1. **Stop.** Do not write the workaround first and explain later.
2. **Describe the divergence**: what the plan expected, what you actually found, one file:line of evidence.
3. **Propose the smallest amendment** that keeps the plan's intent. Smallest — not the redesign you'd prefer.
4. **Get approval** from the human.
5. **Record it** in the plan file's Deviation log:

   ```
   - <date> · Step N — expected: X · found: Y · amendment: Z · approved by: <who>
   ```

6. Continue from the amended step.

The log is the point. A plan whose Deviation log is honest is still a contract after three amendments; a plan silently abandoned is fiction with a nice table.

## A verify-by fails twice

Stop. Report exactly what you tried both times and what the output was — verbatim, not summarized into "it didn't work". The human decides: amend the step, amend the verify-by, or investigate together. Three silent retry loops produce the kind of desperate edits that reviews exist to catch.

## The plan is wrong at the root

If the **Current state** section misread the code — the architecture isn't what planning thought, the extension point doesn't exist — do not rescue the plan step by step. Amending step 2, then 3, then 4 means you're now improvising with extra paperwork. Stop, report, and go back to the `feature-plan` skill with what you learned; re-planning from accurate current state is cheaper than five amendments.

## Never

- Silently skip a step.
- Silently widen a step ("while I was in the file…").
- Leave the Deviation log empty when reality diverged.
- "Fix" a failing verify-by by weakening what it checks.
