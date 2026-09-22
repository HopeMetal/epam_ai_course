# Prompt without skill

Here's the structure of this repository:
     
  ---

  dotnet/command-line-api

  This is the official .NET library for building command-line apps. It ships two NuGet packages: System.CommandLine (the core parser/binder)
  and dotnet-suggest (a global CLI tool for shell completions).

  ---

  Root layout

  ┌──────────────────────────┬──────────────────────────────────────────────────────────────┐
  │           Path                             │                           Purpose                            │
  ├──────────────────────────┼──────────────────────────────────────────────────────────────┤
  │ src/                     │ All production and test projects                             │
  ├──────────────────────────┼──────────────────────────────────────────────────────────────┤
  │ eng/                     │ Build infrastructure (versioning, signing, publishing props) │
  ├──────────────────────────┼──────────────────────────────────────────────────────────────┤
  │ docs/                    │ Design docs (history, technical motivations, goals)          │
  ├──────────────────────────┼──────────────────────────────────────────────────────────────┤
  │ artifacts/               │ Build outputs (generated, not in git)                        │
  ├──────────────────────────┼──────────────────────────────────────────────────────────────┤
  │ Directory.Build.*        │ MSBuild props/targets shared across all projects             │
  ├──────────────────────────┼──────────────────────────────────────────────────────────────┤
  │ Directory.Packages.props │ Central NuGet package version management                     │
  ├──────────────────────────┼──────────────────────────────────────────────────────────────┤
  │ System.CommandLine.slnx  │ Solution file                                                │
  └──────────────────────────┴──────────────────────────────────────────────────────────────┘

  ---

  src/ projects

  ┌────────────────────────────────────────────┬──────────────────────────────────────────────────────────────────────────────────────┐
  │                  Project                                                   │   Role                                                                                                                                                   │
  ├────────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────┤
  │ System.CommandLine                         │ Core library — parser, model binding, invocation, help, completions                  │
  ├────────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────┤
  │ System.CommandLine.Tests                   │ Unit/integration tests for the core library                                          │
  ├────────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────┤
  │ System.CommandLine.ApiCompatibility.Tests  │ API surface compatibility tests (ensures no accidental breaking changes)             │
  ├────────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────┤
  │ System.CommandLine.Benchmarks              │ Performance benchmarks (BenchmarkDotNet)                                             │
  ├────────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────┤
  │ System.CommandLine.Suggest                 │ The dotnet-suggest global tool — registers apps and dispatches completions to shells │
  ├────────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────┤
  │ System.CommandLine.Suggest.Tests           │ Tests for the suggest tool                                                           │
  ├────────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────┤
  │ System.CommandLine.StaticCompletions       │ Generates static shell completion scripts at build time                              │
  ├────────────────────────────────────────────┼──────────────────────────────────────────────────────────────────────────────────────┤
  │ System.CommandLine.StaticCompletions.Tests │ Tests for static completions generation                                              │
  └────────────────────────────────────────────┴──────────────────────────────────────────────────────────────────────────────────────┘

  ---

  Inside System.CommandLine (the core)

  The source is organized by concern:

  - Root symbols: Command.cs, RootCommand.cs, Option.cs, Argument.cs, Symbol.cs, Directive.cs — the declarative model you define
  - Parsing/: Tokenizer, ParseOperation, ParseResult, per-symbol result types (CommandResult, OptionResult, ArgumentResult), conversion
    (ArgumentConverter)
  - Binding/: Binds parsed values to typed models
  - Invocation/: The action pipeline — InvocationPipeline, CommandLineAction, sync/async action wrappers, process termination handling
  - Completions/: Tab-completion infrastructure

---

  Inside System.CommandLine (the core)

  The source is organized by concern:

  - Root symbols: Command.cs, RootCommand.cs, Option.cs, Argument.cs, Symbol.cs, Directive.cs — the declarative model you define
  - Parsing/: Tokenizer, ParseOperation, ParseResult, per-symbol result types (CommandResult, OptionResult, ArgumentResult), conversion
    (ArgumentConverter)
  - Binding/: Binds parsed values to typed models
  - Invocation/: The action pipeline — InvocationPipeline, CommandLineAction, sync/async action wrappers, process termination handling
  - Completions/: Tab-completion infrastructure
  - Help/: Help text generation

---

  The overall flow is: define symbols → parse tokens → bind values → invoke actions, with dotnet-suggest sitting alongside to provide shell
  tab-completion for any app built on the library.


# Notes

1
Name: Identify the agent skill in Claude Code.
Description: What the skill is for and when its used. "Explain repo structure" triggers this skill because it matches the words in the description.
Compatibility: What AI coding assistant can use this skill and what are the prerequisites needed to run this skill.
Metadata: Additional information about the skill like author, version, etc.
Allowed tools: Constrains the skill to use only the tools needed for its work.

2
It first loads project files and looks for a .sln file, but didn't find one because the repo used a .slnx solution
Then it loads some .cs files in the main library project.
It did not read `large-repos.md`.
The `repo-map-template.md` is read before writing the repo map, but 1 more .cs file is read before that.

3
Scripts are used to reduce the token usage of the skill and save context space for the skill.
Running the `scan_repo` script returns a tree of the directory structure, though it is about 3 levels deep, so it misses a few subdirectories, ex. in System.CommandLine.
The `repo-map.md` contained additional information about those subfolders. It left out folders that are ignored by git.

4
> ⚠️ **Write access is scoped**: `allowed-tools` grants `Write` for exactly one purpose — creating or updating `docs/ai/repo-map.md`. Do not write or modify any other file.

The Write tool is only constrained by one sentence in the skill overview after the frontmatter. The Procedure section does not reinforce this constraint. Also there is no Constraints section in the skill description, and no instructions to ask for permission before using the Write tool.

### Before 
2,783 no cache
$0.51
### After
23,933 no cache
$1.58

# Reflection

1
Build / run / test commands. The `what-to-look-for` reference file contained instructions on how to find the commands in the CI workflow files.

2
Parallel run clarified a few things but mostly did the same work, and used more tokens, so using it on this repo is wasteful.

3
Adding .slnx as a file extension for C# solution files.