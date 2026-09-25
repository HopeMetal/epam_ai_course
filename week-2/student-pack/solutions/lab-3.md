# Under the hood

1
Implementing a plan requires shared context because each step builds on the last and needs to know exactly what was done before it.

3
Claude asked for input on Open Questions in the plan and recorded my answers. It also recorded a step that needs a step after it first. So it looks honest to me.

---
# Part D

The added stop clause:

>The change would modify **any file named README.md**. Those are sensitive; stop and ask.

The asked-for edit:

| File                               | Edit                                                                     | Verify by                                                                                                                                            |
| ---------------------------------- | ------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `src/System.CommandLine/README.md` | Add extra information about using a JSON string to encapsulate arguments | Reread that the `src/System.CommandLine/README.md` contains mentions of JSON and an example string such as `{ "--name": "Alice", "--verbose": true}` |

Claude's output:

> Now I've hit the stop condition for Step 5. Per the updated SKILL.md:
> 
> 	The change would modify any file named README.md. Those are sensitive; stop and ask.
> 
> Step 5 requires editing `src/System.CommandLine/README.md.` I need your approval before touching that file.
> 
> What Step 5 calls for: Add a section to `src/System.CommandLine/README.md` documenting the JSON input feature, with an example like `{ "--name": "Alice", "--verbose": true }`.

The added stop clause prevented the edit from being made after it was added to the plan. Claude asked what to do, but the execution completed without the edit being made.

The stop clause might work sometimes. A hook would prevent such an edit from ever being made and allow to control what happens when it is attempted.

---
# Reflect

1
The plan diverged after answering the open questions, and in the step order. All of these were recorded in the log.

2
Since every step in the feature is required for it to be complete, the coordinator-with-subagents pattern would not be helpful. Subagents implementing each step in parallel would not work as they might complete work out-of-order, which could break a build step without something that that step needed to build that a subagent hasn't added yet. A sequential subagent pattern could work, but would require files outside of the context to be read. So the context of the conversation serves as a record of what's finished and still needs to be done, and anything that was found during implementation of previous steps that would affect later steps.

3
The feature should pass tests and local review by Claude before a PR is made.