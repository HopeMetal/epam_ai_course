# Lab 3 — The Coder Agent

**Works**: solo, or pairs (one approves writes, one watches the transcript) · **Needs**: Lab 2's `out/architecture.json` and `out/test-cases.json`

You will turn test cases into passing code — first in one shot, then with an agent that has tools, a human approval gate and three different ceilings — and find out what happens when the agent decides the tests are the problem.

## Scenario

Everything so far was a chain: input in, output out, no decision about what to do next. Making tests pass is different: read, write, run, read the failure, write again. That is a loop with tools, which is what an agent is. The tests are the contract. The agent does not get to renegotiate it.

## Part A — One-shot baseline

Same route as Lab 2 Part A — DIAL chat UI on your pipeline's deployment, or a throwaway script. Prompt, followed by the contents of `out/architecture.md` and `out/test-cases.md`:

> *Implement this architecture in Python 3.11, standard library only, so that these test cases pass. Output one file per component as a fenced code block preceded by its path.*

Save the answer as `out/baseline-code/answer.md` and extract the files into `out/baseline-code/`. Have Claude Code — outside the pipeline — write pytest tests from `out/test-cases.md` into `out/baseline-code/tests/`, one test per case, named by its id. Run `pytest` there. Record passes, failures, and how long this took you.

## Part B — The agent

Branch `lab-3-coder` from `lab-2-design`. Fresh session:

> */opsx:propose add-coder-agent: an agent stage that implements the code. Workspace is out/workspace/. First, deterministically, write pytest files from out/test-cases.json into out/workspace/tests/ — one test function per case, named by its id. Then an agent (create_agent) with tools read_file, write_file, list_files and run_tests (pytest inside the workspace, 60 s timeout, returns the tail of the output) is asked to make them pass. All paths resolve inside the workspace; anything outside is refused. write_file refuses paths under tests/. Human approval before every write_file via HumanInTheLoopMiddleware — approve, edit or reject. Limits: ToolCallLimitMiddleware run_limit 40, ModelCallLimitMiddleware run_limit 30, recursion_limit 120. The final answer is a typed CoderReport: tests passed and failed, files written, requirement IDs blocked with reasons. Writes out/coder-report.{json,md}. CLI: python -m prd_pipeline code.*

Spec scenarios to insist on before apply: *write under tests/ → refused, and the agent is told why*; *path outside the workspace → refused*; *all tests pass → the agent stops*; *a limit is reached → the report says which, with the last pytest output*; *human rejects a write → the agent receives the message and continues*.

Apply, verify, archive. Run `python -m prd_pipeline code`. Approve writes one by one. **Read each before approving** — you are now the reviewer Claude Code usually makes *you* be.

### Worksheet

| Signal | One-shot | Agent |
|--------|----------|-------|
| Tests passing / total | | |
| Model calls | 1 | |
| Files written | | |
| Writes you rejected or edited, and why | n/a | |
| Attempts to touch `tests/` | n/a | |
| Tokens | | |
| Which ceiling fired, if any | n/a | |
| Wall clock | | |

## Part C — Open the hood

1. Read the four tool functions. **The docstring is the API the model sees.** Make one docstring vaguer, run again, and watch what changes. Put it back.
2. Find `HumanInTheLoopMiddleware`, the `checkpointer`, the `thread_id`, and `Command(resume=...)`. Draw the loop: where does the process pause, and where does your answer re-enter?
3. Three ceilings: which counts money, which counts side effects, which counts graph steps? Set `recursion_limit` to 10 and run. What error do you get, and would a teammate understand it?
4. This is **Single-agent / ReAct** plus **Loop** plus **Human-in-the-loop** from Week 2's page. Week 2 Lab 3 argued for *zero subagents* on implementation. Does the argument hold here?

## Part D — Trip your own wire

Edit one test case in `out/test-cases.json` so that it cannot be satisfied alongside another (two tests demanding different channels for the same input will do). Regenerate the workspace tests and run `code` again. Watch: does the agent try to edit `tests/`? Does the tool refuse? Does it report the requirement as blocked, or loop until a ceiling fires? Which of the three would you want in production?

Then run once with the approval gate off (a flag, or remove the middleware). Same outcome? Same comfort?

## Part E — Reflect

Answer in 2–3 sentences each (in class: discuss as a group first):

1. One-shot got N of M tests. The agent got K of M at X tokens. Was the loop worth it, and where did the extra iterations go?
2. What did you learn about the agent from what you rejected?
3. Tests were generated deterministically and the agent couldn't touch them. Which of those two decisions mattered more?

## What to submit

- Worksheet, `out/coder-report.md`
- The transcript fragment where the agent hit the `tests/` guard or a ceiling in Part D
- Reflections

💡 Keep the workspace and the branch. Lab 4 orchestrates all four stages.
