# Test quality taxonomy

Classify every test you write or review. The tags come from Week 1's acceptance-criteria lab, adapted from ACs to plans — the important tag is still the last one.

| Tag | Meaning |
|-----|---------|
| **Plan-direct** | Directly proves a behavior listed in the plan's Test plan |
| **Negative** | Invalid input / error path for a planned behavior |
| **Boundary** | Edge of a range or limit the plan mentions |
| **Beyond-plan** | Valid, useful scenario the plan never listed — keep it, and tell the human the plan was incomplete |
| **Invented** | Asserts behavior found in **no** plan, requirement, or human answer — the test canonizes whatever the code happens to do |

⚠️ **Invented is the tag that costs money.** An Invented test that passes today turns accidental behavior into a frozen spec: the next developer who fixes the actual bug breaks the test, reads it as intent, and reverts the fix. When you catch yourself writing one, you have found a question for a human, not a test.

## Signals a test is Invented

- Its expected value came from running the code, not from reading the plan.
- It asserts formatting, ordering, or casing no requirement mentions.
- Its name describes the implementation ("uses LinkedHashMap") rather than a behavior.
- Deleting it would make nobody's requirement unprovable.

## Quality bar for every test, regardless of tag

- The name states the behavior, not the method under test (`rejects_expired_code`, not `test_validate_2`).
- One behavior per test — a test with five asserts across three behaviors fails uninformatively.
- The failure message alone tells a reader what broke.
- No test depends on another test having run first.

## Team categories

<!-- Extend this taxonomy with categories your team needs, and mirror each addition
     in the coverage critic's prompt in SKILL.md step 6, e.g.:
| **Concurrency** | Two actors on the same resource; planned behavior under a race |
| **i18n** | Behavior under non-default locale/encoding the plan covers |
-->
