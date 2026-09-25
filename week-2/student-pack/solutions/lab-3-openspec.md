# Plan-implement comparison

| Skill from lab                        | Skills from OpenSpec                                                                                                                                                                                                                                                                                                                                        |
| ------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| All in 1                              | Multiple files with different purposes. Detailed proposal with impact assessment. Proposal contains what is added and modified. Design contains details of decisions, alternatives considered and why they were rejected. Tasks is a detailed checklist of what each step requires. Much more readable than the table from the planning skill from the lab. |
| Asks before investigation, and after. | Asks multiple questions while exploring the idea. Feels more interactive.                                                                                                                                                                                                                                                                                   |
|                                       | Spec itself is a document containing a list of requirements with a Scenario, When, Then structure.                                                                                                                                                                                                                                                          |
|                                       | The resulting plan actually has more different ways the JSON can be added as arguments that the skill from the lab hadn't considered.                                                                                                                                                                                                                       |

# Diff results

```
git diff <base>..lab-3-baseline --stat

 .claude/skills/implement-plan/SKILL.md             |  50 ------
 .../implement-plan/references/execution-rules.md   |  27 ---
 .../skills/implement-plan/references/when-stuck.md |  32 ----
 Directory.Packages.props                           |   1 +
 .../JsonArgumentPreprocessorTests.cs               | 199 +++++++++++++++++++++
 src/System.CommandLine/ParserConfiguration.cs      |  18 ++
 .../Parsing/CommandLineParser.cs                   |   5 +
 .../Parsing/JsonArgumentPreprocessor.cs            | 110 ++++++++++++
 src/System.CommandLine/System.CommandLine.csproj   |   1 +
 9 files changed, 334 insertions(+), 109 deletions(-)

git diff <base>..lab-3-feature --stat

 Directory.Packages.props                           |   1 +
 docs/ai/plan-json-args-input.md                    |   9 +-
 .../ParserTests.JsonInput.cs                       | 130 +++++++++++++++++
 .../Parsing/CommandLineParser.cs                   |  11 ++
 .../Parsing/JsonArgsPreprocessor.cs                | 158 +++++++++++++++++++++
 src/System.CommandLine/System.CommandLine.csproj   |   1 +
 6 files changed, 306 insertions(+), 4 deletions(-)

git diff lab-3-openspec-plan..lab-3-openspec-feature --stat

 Directory.Packages.props                           |   1 +
 ...tem_CommandLine_api_is_not_changed.approved.txt |   5 +
 .../JsonArgumentTokenReplacerTests.cs              | 414 +++++++++++++++++++++
 .../JsonArgumentTokenReplacer.cs                   | 187 ++++++++++
 .../Parsing/TryReplaceTokenExtensions.cs           |  39 ++
 src/System.CommandLine/System.CommandLine.csproj   |   1 +
 6 files changed, 647 insertions(+)

```

# Assessment

The OpenSpec change proposal and design spec were more detailed than the basic plan skill.
Implemented changes covered a similar number of files.
The implementation plans were not the same: the basic skill described a feature where JSON is given inline in the CLI, whereas the OpenSpec plan described JSON arguments plugged in from another tool in a `.json` file. OpenSpec asked for clarification of what the intended way was, so it was not a surprise.
The OpenSpec preferred to add new files, but that may be caused by the differences in implementation details between it and the basic skill.