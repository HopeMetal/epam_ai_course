# Reference — LangChain 1.x, the parts this week uses

## Read the source first

📄 **https://docs.langchain.com/oss/python/langchain/overview** — the LangChain 1.x docs. This document does not restate them. It gives you three things the docs can't: which construct each lab exercises, snippets **verified against the versions `setup.md` pins** (langchain 1.4, langchain-openai 1.6, langgraph 1.2) so you can tell current API from stale training data, and the mapping back to Week 2's agentic-pattern page.

⚠️ LangChain changed a lot in 1.0. AI assistants trained on older code will confidently generate `AgentExecutor`, `initialize_agent`, `LLMChain`, `ConversationBufferMemory`, `langchain.chains.*`. **All of that is legacy.** If Claude Code generates it, point it at this file. That is also why Lab 1 has you write the project context before the first line of code.

## The map: concept → lab → construct

| Concept | Lab | Construct (import) | One line |
|---|---|---|---|
| Chat model on DIAL | 1 | `AzureChatOpenAI` (`langchain_openai`) — inside the `get_model()` factory you build in Lab 1 | DIAL speaks the Azure dialect; no adapter needed |
| Messages | 1 | `SystemMessage`, `HumanMessage`, `AIMessage` (`langchain_core.messages`) | The unit of conversation; `AIMessage.usage_metadata` carries token counts |
| Prompt templates | 1 | `ChatPromptTemplate.from_messages` (`langchain_core.prompts`) | Variables in `{braces}`; the template is a Runnable |
| Structured output | 1 | `model.with_structured_output(PydanticModel)` | Returns the model *instance*, not text; default method `json_schema` |
| Runnable composition | 1, 2 | `prompt \| model` (`langchain_core.runnables`) | Every piece has `.invoke / .batch / .stream`; `\|` chains them |
| Streaming | 1 | `for chunk in chain.stream(...)` | Tokens as they arrive; structured output streams partial objects |
| Parallel branches | 2 | `RunnableParallel(a=..., b=...)` | Same input, both branches, dict out — architecture ∥ test cases |
| Glue code as a step | 2 | `RunnableLambda(fn)` | Any function becomes a pipeline step (validation, file writes) |
| Batch | 2 | `chain.batch([inputs])` | N independent calls, concurrency handled for you |
| Tools | 3 | `@tool` (`langchain.tools`) | The **docstring is the API the model sees**; type hints become the schema |
| Agent | 3 | `create_agent(model, tools, system_prompt, middleware, checkpointer)` (`langchain.agents`) | The tool-calling loop, built on LangGraph; returns a graph you `.invoke` |
| Human approval | 3 | `HumanInTheLoopMiddleware(interrupt_on={...})` + `Command(resume=...)` | Pauses before a tool runs; needs a `checkpointer` and a `thread_id` |
| Bounded loops | 3 | `ToolCallLimitMiddleware`, `ModelCallLimitMiddleware`, `recursion_limit` | Three different ceilings — know which one you hit |
| Structured final answer | 3, 4 | `response_format=ToolStrategy(Schema)` → `result["structured_response"]` | The agent's *report*, typed |
| Model fallback | 4 | `ModelFallbackMiddleware(primary, secondary)` | On error, same request to the next DIAL deployment |
| Retry / fallback for chains | 4 | `.with_retry()`, `.with_fallbacks([...])` | The Runnable-level equivalents, for non-agent stages |
| Cost accounting | 4 | `UsageMetadataCallbackHandler` (`langchain_core.callbacks`) | Per-model token totals across a whole run |
| Judge | 5 | A plain structured-output chain on a **different** deployment | Review-and-critique with a typed verdict |

## Verified snippets

All of these were run against an Azure-shaped endpoint with the pinned versions. Adapt names, keep shapes.

### The model, once (Lab 1 — the factory)

```python
import os
from langchain_openai import AzureChatOpenAI

def get_model(deployment: str | None = None, temperature: float = 0.0) -> AzureChatOpenAI:
    """The only place that talks to DIAL.

    DIAL is Azure-shaped: POST {DIAL_URL}/openai/deployments/{deployment}/chat/completions?api-version=...
    with the key in the `api-key` header — exactly what AzureChatOpenAI sends, so no adapter is needed.
    """
    return AzureChatOpenAI(
        azure_endpoint=os.environ["DIAL_URL"],
        api_key=os.environ["DIAL_API_KEY"],
        api_version=os.environ.get("DIAL_API_VERSION", "2024-10-21"),
        azure_deployment=deployment or os.environ.get("DIAL_DEPLOYMENT", "gpt-4o"),
        temperature=temperature,
    )

model = get_model()                    # DIAL_DEPLOYMENT
mini  = get_model("gpt-4o-mini")       # any deployment your key can see
```

Verified: with these arguments the request goes to `/openai/deployments/gpt-4o-mini/chat/completions?api-version=2024-10-21` carrying an `api-key` header. Load `.env` yourself (`python-dotenv`) before calling it.

### A stage as a chain with structured output (Lab 1)

```python
from pydantic import BaseModel, Field
from langchain_core.prompts import ChatPromptTemplate

class Requirement(BaseModel):
    id: str = Field(description="FR-n or NFR-n")
    statement: str = Field(description="One testable sentence using SHALL")
    source: str = Field(description="Quote from the PRD this comes from")

class Requirements(BaseModel):
    functional: list[Requirement]
    non_functional: list[Requirement]
    open_questions: list[str] = Field(description="Ambiguities and contradictions, naming the IDs involved")

prompt = ChatPromptTemplate.from_messages([
    ("system", "You are a requirements analyst. Extract, do not invent. Flag every undefined term."),
    ("human", "PRD:\n\n{prd}"),
])
requirements_chain = prompt | get_model().with_structured_output(Requirements)
reqs = requirements_chain.invoke({"prd": prd_text})     # -> Requirements instance
```

⚠️ **DIAL gotcha.** `with_structured_output` defaults to `method="json_schema"`, which needs an OpenAI-family deployment and `DIAL_API_VERSION` ≥ `2024-08-01-preview`. A deployment from another vendor may reject it with a 400. Then use `with_structured_output(Schema, method="function_calling")` — same result, tool-calling under the hood.

### Streaming and token usage (Lab 1)

```python
for chunk in (prompt | get_model()).stream({"prd": prd_text}):
    print(chunk.content, end="", flush=True)

reply = get_model().invoke("hi")
reply.usage_metadata          # {'input_tokens': .., 'output_tokens': .., 'total_tokens': ..}
```

### Parallel stages and glue (Lab 2)

```python
from langchain_core.runnables import RunnableParallel, RunnableLambda

def check_traceability(bundle: dict) -> dict:
    known = {r.id for r in bundle["requirements"].functional}
    for case in bundle["tests"].cases:
        unknown = set(case.covers) - known
        if unknown:
            raise StageError(f"test {case.id} references unknown requirement(s): {sorted(unknown)}")
    return bundle

design_stage = RunnableParallel(
    requirements=RunnableLambda(lambda x: x["requirements"]),   # pass through
    architecture=architecture_chain,
    tests=test_design_chain,
) | RunnableLambda(check_traceability)

bundle = design_stage.invoke({"requirements": reqs, "requirements_md": reqs_md})
```

### Tools and the coder agent with approval and limits (Lab 3)

```python
from langchain.tools import tool
from langchain.agents import create_agent
from langchain.agents.middleware import HumanInTheLoopMiddleware, ToolCallLimitMiddleware, ModelCallLimitMiddleware
from langgraph.checkpoint.memory import InMemorySaver
from langgraph.types import Command

@tool
def write_file(path: str, content: str) -> str:
    """Write content to a file inside the workspace. Paths under tests/ are read-only and will be refused."""
    target = safe_path(path)                       # resolve + refuse '..' and anything outside the workspace
    if target.is_relative_to(WORKSPACE / "tests"):
        raise PermissionError("tests/ is the contract; the coder may not edit it")
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(content, encoding="utf-8")
    return f"wrote {len(content)} bytes to {path}"

coder = create_agent(
    model=get_model(),
    tools=[read_file, write_file, list_files, run_tests],
    system_prompt=CODER_PROMPT,
    middleware=[
        HumanInTheLoopMiddleware(interrupt_on={"write_file": True}),   # approve / edit / reject / respond
        ToolCallLimitMiddleware(run_limit=40, exit_behavior="end"),
        ModelCallLimitMiddleware(run_limit=30),
    ],
    checkpointer=InMemorySaver(),                                     # required by the interrupt
)
config = {"configurable": {"thread_id": run_id}, "recursion_limit": 120}

result = coder.invoke({"messages": [{"role": "user", "content": task}]}, config=config)
while "__interrupt__" in result:
    request = result["__interrupt__"][0].value["action_requests"][0]   # {'name': 'write_file', 'arguments': {...}}
    decision = ask_human(request)                                       # {"type": "approve"} | {"type": "reject", "message": "..."}
    result = coder.invoke(Command(resume={"decisions": [decision]}), config=config)

print(result["messages"][-1].content)
```

Three ceilings, three meanings: `ModelCallLimitMiddleware` counts LLM calls (your money), `ToolCallLimitMiddleware` counts tool executions (side effects), `recursion_limit` counts graph steps (roughly model + tool steps together — set it well above the other two or it fires first with a confusing error).

### A typed report from the agent (Labs 3–4)

```python
from langchain.agents.structured_output import ToolStrategy

class CoderReport(BaseModel):
    tests_passed: int
    tests_failed: int
    files_written: list[str]
    blocked_on: list[str] = Field(description="Requirement IDs that could not be implemented, with why")

coder = create_agent(..., response_format=ToolStrategy(CoderReport))
report = coder.invoke(...)["structured_response"]
```

### Fallbacks, retries, cost (Lab 4)

```python
from langchain.agents.middleware import ModelFallbackMiddleware
orchestrator = create_agent(model=get_model(), tools=specialists,
                            middleware=[ModelFallbackMiddleware(get_model(os.environ["DIAL_DEPLOYMENT_FALLBACK"]))])

robust_chain = (prompt | get_model()).with_retry(stop_after_attempt=3) \
                                     .with_fallbacks([prompt | get_model(FALLBACK)])

from langchain_core.callbacks import UsageMetadataCallbackHandler
usage = UsageMetadataCallbackHandler()
bundle = pipeline.invoke(inputs, config={"callbacks": [usage]})
usage.usage_metadata      # {'gpt-4o': {'input_tokens': .., ...}, 'gpt-4o-mini': {...}}
```

### Specialists as tools (Lab 4)

```python
@tool
def run_requirements_stage(prd_path: str, feedback: str = "") -> str:
    """Turn the PRD at prd_path into requirements. Pass feedback from downstream stages to re-run with corrections. Returns the path of the written artifact."""
    reqs = requirements_chain.invoke({"prd": Path(prd_path).read_text(), "feedback": feedback})
    return write_artifact("requirements", reqs)
```

The orchestrator's tools are your Lab 1–3 stages. Its system prompt is the process; the tools are the org chart. Nothing about the stages changes.

### Testing without the network

```python
from langchain_core.language_models.fake_chat_models import GenericFakeChatModel
fake = GenericFakeChatModel(messages=iter([AIMessage(content='{"functional": [], ...}')]))
```

Inject the fake where `get_model()` would be called (a parameter with a default, or monkeypatch). Tests that hit DIAL are not unit tests.

## Mapping to Week 2's pattern page

| Google's pattern | Week 2 (Claude Code) | Week 3 (your LangChain code) |
|---|---|---|
| Sequential | skills chained by artifacts | `prompt \| model \| RunnableLambda` and stage → stage via `out/` files |
| Parallel | explorer subagents | `RunnableParallel` — architecture and test design from the same requirements |
| Human-in-the-loop | permission prompts, plan checkpoints | Lab 2's open-questions stop; `HumanInTheLoopMiddleware` on `write_file` |
| Single-agent / ReAct | the default Claude Code loop | `create_agent` — every tool call is *act*, every tool result is *observe* |
| Loop | bounded red→green in `test-changes` | the coder's test-fix cycle, bounded by the three ceilings |
| Coordinator | `self-review`'s coordinator | Lab 4's orchestrator with specialists as tools |
| Custom logic | `scan_repo.sh` | `check_traceability`, `safe_path`, the tests/ guard — deterministic where determinism is cheap |
| Review and critique | fresh reviewer subagents | Lab 5's judge on a different deployment that never saw the generator's prompt |

You built the consumer side of these in Week 2. This week you build the producer side, and you'll feel where each abstraction earns its keep.

## Legacy you will see, and what replaces it

| If Claude generates… | Use instead |
|---|---|
| `from langchain.agents import AgentExecutor, initialize_agent, create_react_agent` | `from langchain.agents import create_agent` |
| `LLMChain`, `SequentialChain`, `langchain.chains.*` | `prompt \| model`, `RunnableParallel`, `RunnableLambda` |
| `ConversationBufferMemory`, `langchain.memory` | a `checkpointer` + `thread_id` on the agent |
| `PydanticOutputParser` + "respond in JSON" prompts | `model.with_structured_output(Schema)` |
| `langchain_community.chat_models.AzureChatOpenAI` | `langchain_openai.AzureChatOpenAI` — via `get_model()` |
| `ChatOpenAI(openai_api_base=DIAL_URL)` | `get_model()`; DIAL is Azure-shaped, not OpenAI-shaped |
