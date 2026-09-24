Feature:
Functionality to allow command line arguments to be specified by JSON.
Command line should accept a JSON string after the CLI application name and obtain arguments from the deserialized object.

# Baseline
---

Implementation Plan: JSON Command Line Arguments

Goal

Allow a CLI app to accept a JSON string as the first argument after the app name, which gets expanded into standard CLI tokens
before parsing. For example:

myapp {"--output": "file.txt", "--verbose": true, "--count": 3}

is treated the same as:

myapp --output file.txt --verbose --count 3

---

JSON → Token Mapping Rules

	┌────────────────────────┬───────────────────────────────┐
	│    JSON value type     │            Mapping            │
	├────────────────────────┼───────────────────────────────┤
	│ "--flag": true         │ --flag (flag present)         │
	├────────────────────────┼───────────────────────────────┤
	│ "--flag": false        │ (omitted)                     │
	├────────────────────────┼───────────────────────────────┤
	│ "--option": "value"    │ --option value                │
	├────────────────────────┼───────────────────────────────┤
	│ "--option": 42         │ --option 42                   │
	├────────────────────────┼───────────────────────────────┤
	│ "--option": ["a","b"]  │ --option a --option b         │
	├────────────────────────┼───────────────────────────────┤
	│ Keys without -- prefix │ -- is prepended automatically │
	└────────────────────────┴───────────────────────────────┘

---

New File: `src/System.CommandLine/Parsing/JsonArgumentPreprocessor.cs`

A static class responsible for detecting and converting a JSON string into a IReadOnlyList\<string> of CLI tokens. Key method signatures:

	internal static bool TryPreprocess(
	IReadOnlyList<string> args,
	out IReadOnlyList<string> expandedArgs,
	out string? errorMessage)

Uses `System.Text.Json.JsonDocument` to walk the root object's properties and emit token strings. No reflection needed — AOT safe.

---

Modified File: src/System.CommandLine/Parsing/CommandLineParser.cs

Add a new public overload and hook preprocessing into the existing Parse(Command, IReadOnlyList\<string>, ...) path:

	public static ParseResult ParseJson(
	Command command,
	string jsonArgs,
	ParserConfiguration? configuration = null)

Detection: the first non-whitespace token starts with { → treat as JSON input. This avoids breaking existing callers.

---

Modified File: `src/System.CommandLine/System.CommandLine.csproj`

Add a conditional package reference for netstandard2.0 (where System.Text.Json is not in-box):

	<ItemGroup Condition="'$(TargetFramework)' == 'netstandard2.0'">
		<PackageReference Include="System.Text.Json" />
	</ItemGroup>

---

New File: src/System.CommandLine.Tests/Parsing/JsonArgumentPreprocessorTests.cs

Unit tests covering:
- Valid JSON object with string, bool, numeric, and array values
- Key names with and without -- prefix
- false boolean values being omitted
- Invalid/malformed JSON returns a parse error (not an exception)
- Empty JSON object {} produces no tokens
- Non-JSON first argument is passed through unchanged

---

Files Changed Summary

	┌───────────────────────────────────────┬────────────────────────────────────┐
	│                File                   │              Change                │
	├───────────────────────────────────────┼────────────────────────────────────┤
	│ Parsing/JsonArgumentPreprocessor.cs   │ New - core conversion logic        |
	├───────────────────────────────────────┼────────────────────────────────────┤
	│ Parsing/CommandLineParser.cs          │ Modified - add ParseJson overload  │
	├───────────────────────────────────────┼────────────────────────────────────┤
	│ System.CommandLine.csproj             │ Modified - add netstandard2.0      |
	|                                       | package ref                        │
	├───────────────────────────────────────┼────────────────────────────────────┤
	│ Tests/Parsing/JsonArgument            │ New - unit tests                   |
	| PreprocessorTests.cs                  |                                    |
	└───────────────────────────────────────┴────────────────────────────────────┘
---

Does this plan look right, or would you like to adjust the JSON→token mapping rules or the integration point (e.g., automatic detection in Parse vs an explicit ParseJson overload)?

# Questions by Claude

## Step 2 — Restate and confirm (checkpoint 1)


Here is my understanding of the feature:


> Accept a JSON string as the first argument immediately after the CLI application name (e.g. myapp '{"output":"./bin","verbose":true}'). Deserialize that JSON object and map its keys to the application's declared Option\<T> / Argument\<T> names, populating them as if the user had passed the equivalent flags. This is an alternative input mode, not a replacement for normal CLI syntax.


Out of scope (initial guess):
	dotnet-suggest / StaticCompletions packages — no impact
	Tab-completion behavior
	Help system changes

Does this match your intent? Anything to add or correct before I investigate the codebase?

## Step 7 — Present decisions (checkpoint 2)


All four investigations returned. Here are the decisions I'll make for you — approve, redirect, or I'll tag them *\[ASSUMPTION — confirm]* in the plan:


**Decision 1 — Where the logic lives**
	Insert JSON pre-processing in the private Parse method at src/System.CommandLine/Parsing/CommandLineParser.cs:151, immediately before arguments.Tokenize(...). This is the single choke point for all parse paths (both string[] and string overloads converge here), so JSON input will work transparently with the existing command.Parse(...) and command.Invoke(...) API without any new public surface.


**Decision 2 — System.Text.Json dependency (risk)**
	The library targets netstandard2.0 (confirmed in .csproj:4), where System.Text.Json is not in-box. The library is also IsAotCompatible=true on the modern TFM, requiring source-generated serialization, not reflection. Three options:
	
	A — Add System.Text.Json as a NuGet reference for netstandard2.0; use
	[JsonSerializable] source gen for the modern TFM. Cleanest; adds one new dep.
	B — #if NET6_0_OR_GREATER guard; JSON input silently does nothing on older 
	TFMs.
	C — Write a minimal bespoke JSON object parser; zero new dependency.

I'll default to Option A in the plan — *\[ASSUMPTION — confirm].


**Decision 3 — Detection heuristic**
	Detect JSON if args.Count == 1 && args\[0].TrimStart().StartsWith('{'). A lonely {-prefixed single arg is not a valid CLI option or positional in any existing convention, so false positives are unlikely. — *\[ASSUMPTION — confirm]


**Decision 4 — Value mapping rules**
	String/number value "output": "./bin" → \["--output", "./bin"]
	Boolean true "verbose": true → \["--verbose"] (flag-style, no value)
	Boolean false "verbose": false → omitted entirely
	Array "items": \["a","b"] → \["--items", "a", "--items", "b"] (repeated option)
	— *\[ASSUMPTION — confirm]

# Under the hood

1
Out of Scope and Open Questions exists to instruct Claude to include these sections when planning. Deviation log is empty because its used for implementation.

2
If the 1st human checkpoint were removed the out-of-scope parts would likely be missed. Keeping it instructs Claude to specifically find such parts and wait for confirmation that it is intended.

3
Result from first sub-agent:
> **Answer**: The earliest public entry point where raw `string[]` args arrive is `CommandLineParser.Parse(Command, IReadOnlyList<string> args, ParserConfiguration?)` at line 21. The best insertion point for JSON detection and transformation is at line 151 in the private `Parse` overload (lines 138-166), immediately **before** `arguments.Tokenize(...)` is called — replace or preprocess `arguments` there. At that point, you have the full `IReadOnlyList<string>` before any tokenization occurs, so you can inspect `arguments[0]`, detect a JSON object string (e.g., starts with `{`), deserialize it, and build a synthetic `string[]` of `--key value` tokens to substitute in place of the original `arguments`.
> 
> **Evidence**:
> - `C:\Users\LiudvikasDapsys\OneDrive - EPAM\command-line-api\src\System.CommandLine\Parsing\CommandLineParser.cs:21` — public `Parse(Command, IReadOnlyList<string>, ParserConfiguration?)` is the first public surface that receives a `string[]`.
> - `CommandLineParser.cs:32` — the `Parse(Command, string, ...)` overload splits first, then delegates to the same private method.
> - `CommandLineParser.cs:138-165` — the private `Parse` overload is the single choke point; `arguments.Tokenize(...)` at line 151 is the last moment before the array is consumed.
> - `C:\Users\LiudvikasDapsys\OneDrive - EPAM\command-line-api\src\System.CommandLine\Parsing\ParseOperation.cs:25-44` — `ParseOperation` receives already-tokenized `List<Token>`, making it too late to inject new tokens from a JSON string naturally.
> 
> **Confidence**: High — both files were read in full; the call chain is linear and unambiguous.
> 
> **Not checked**: Extension methods on `Command` (e.g., `command.Parse(args)`), `InvokeAsync` entry points, or any middleware/pipeline hooks that might also accept raw args upstream of `CommandLineParser`.
> 18830661897

The file:line claim holds up when checking the code.

# Reflection

1
Decision 2 in Part 7. If not caught during implementation it could break the library. Omitting the source-generated `System.Text.Json` NuGet package will cause compile-time errors and cause the AoT linker to ignore reflection-based serialization on certain .NET environments.

2
In SKILL.md the human checkpoints were placed before and after investigation. This made Claude ask first if it understood the feature correctly, then ask about if its assumptions for implementation details are correct after investigation. This makes it possible to steer Claude towards the correct feature and implementation, without having to read the entire plan and send follow-up prompts afterwards.

3
...when the change touches multiple files in different parts of the codebase.