# Severity rubric

Same definitions as Week 1's code-review lab — deliberately, so scores compare across weeks.

| Level | Definition |
|-------|-----------|
| **Critical** | Exploitable, or silently corrupts data/money |
| **High** | Breaks under realistic production conditions (load, concurrency) |
| **Medium** | Wrong result in edge cases, or degrades over time |
| **Low** | Works, but a trap for the next change |

## The qualifying rule

**No failure scenario, no finding.** Every finding must state a concrete "with input X, Y happens". "This looks wrong" is a feeling; "a code containing `'` breaks the query and returns all rows" is a finding. Findings that cannot produce a scenario are recorded as discards, not findings — the human may resurrect them.

## Calibration examples

- SQL built by string concatenation from user input → **Critical** (exploitable), even if "we control the callers today".
- New cache read-modify-write without a lock, service runs multi-instance → **High** (realistic load breaks it).
- Discount rounds half-up where the plan says banker's rounding → **Medium** (wrong result in edge cases) — unless money silently diverges from the ledger, then it's **Critical**.
- Helper duplicated instead of imported from `utils/` → **Low** (trap for the next change), Conventions category.

## What severity is not

- Not effort-to-fix: a one-character Critical is still Critical.
- Not certainty: an unproven-but-plausible Critical scenario stays Critical with a note, it does not get discounted to Medium.
- Not politeness: this report is pre-PR; inflation and deflation both cost the author.
