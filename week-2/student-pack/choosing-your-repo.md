# Choosing Your Repo

Week 2 runs on a real repository that you bring. **One repo for all five labs** — the labs chain (map → plan → implement → test → review), so switching repos mid-week resets everything you've built.

## The checklist

- **Real but not precious.** A side project, a fork, a sandbox copy of a work repo. You'll work on branches and never touch the base branch — but pick something where a stray commit wouldn't hurt anyway.
- **Big enough to be honest, small enough to explore.** Roughly 30+ source files; below that, "explaining the structure" is a party trick. 💡 Don't fear large: the `repo-map` skill handles big repos with parallel subagents — err larger rather than toy-sized.
- **Has a test suite that runs locally, in minutes.** ⚠️ This is the hard requirement — labs 4 and 5 depend on it. Verify now, not Thursday: run the repo's test command end to end once.
- **Builds without secret infrastructure.** No VPN-only package feeds, no credentials you don't have.
- **Git, clean tree, branch rights.** You'll create and delete branches freely.
- **Non-sensitive.** ⚠️ You'll be feeding this code to an AI tool. Check your organization's and your client's AI-tooling policy before Lab 1 — *your code, your call* is ground rule 6 for a reason.

## No suitable repo? Fork one

Any mid-sized OSS project with a runnable suite works. Three that fit the checklist, across stacks:

| Repo | Stack | Test command |
|------|-------|--------------|
| `pallets/click` | Python | `pytest` |
| `sindresorhus/ky` | TypeScript | `npm test` |
| `dotnet/command-line-api` | C# | `dotnet test` |

Fork it (so you can push branches), clone your fork, and treat it as yours for the week.

## Readiness check — run before Lab 1

```
git clone <your-repo> && cd <repo>
git checkout -b week2-warmup
<run the test suite once — must pass>
git symbolic-ref --short refs/remotes/origin/HEAD   # note your base branch name
git checkout - && git branch -d week2-warmup
```

If all four lines behave, you're ready. If the tests don't pass on a fresh clone, fix that or pick another repo — every lab after Tuesday assumes a green baseline.
