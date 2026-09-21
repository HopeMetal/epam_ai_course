# Review checklist

The categories every reviewer applies. The first seven are the Week 1 defect taxonomy; the last two exist because this review runs pre-PR, where tests and conventions are still cheap to fix.

| Category | Look for |
|----------|----------|
| **Security** | Injection (SQL/command/path), hardcoded secrets, missing input validation, authz checks skipped on new paths |
| **Correctness** | Off-by-one, wrong types for the domain (money as float, naive datetimes), floating-point comparisons, unhandled boundaries |
| **Concurrency** | Shared mutable state without synchronization, check-then-act races, non-atomic read-modify-write |
| **Async** | Fire-and-forget with no error path, sync-over-async (`.Result`/`.Wait()`, blocking on promises), unawaited/undrained async calls |
| **Resources** | Unclosed handles/connections, per-call clients that should be shared, leaks on exception paths |
| **Error handling** | Swallowed exceptions, errors converted into business values, catch-all handlers hiding specific failures |
| **Time & culture** | Local vs UTC mixing, culture/locale-sensitive parsing and formatting, hidden timezone assumptions |
| **Tests & coverage** | Changed behavior with no changed test, tests asserting current behavior instead of required behavior (Invented), assertions weakened to pass |
| **Conventions** | Departures from the repo's own naming, error-handling, and structure patterns — judged against neighboring code, not personal taste |

Reviewers cite the category name verbatim in each finding so the merged report can be sorted and compared across reviewers.
