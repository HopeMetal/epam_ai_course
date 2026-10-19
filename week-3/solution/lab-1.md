```
Baseline
git diff master --stat
 pipeline.py | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 
OpenSpec 
git diff master --stat
 .gitignore                                         |   2 +-
 openspec/changes/archive/.gitkeep                  |   0
 .../.openspec.yaml                                 |   2 +
 .../2026-09-28-add-requirements-stage/design.md    |  74 +++++++++++++
 .../2026-09-28-add-requirements-stage/proposal.md  |  35 +++++++
 .../specs/requirements-stage/spec.md               | 114 +++++++++++++++++++++
 .../2026-09-28-add-requirements-stage/tasks.md     |  36 +++++++
 openspec/config.yaml                               |  28 +++++
 openspec/specs/.gitkeep                            |   0
 openspec/specs/requirements-stage/spec.md          | 114 +++++++++++++++++++++
 pyproject.toml                                     |  12 +++
 src/prd_pipeline.egg-info/PKG-INFO                 |   4 +
 src/prd_pipeline.egg-info/SOURCES.txt              |   9 ++
 src/prd_pipeline.egg-info/dependency_links.txt     |   1 +
 src/prd_pipeline.egg-info/top_level.txt            |   1 +
 src/prd_pipeline/__init__.py                       |   1 +
 src/prd_pipeline/__main__.py                       |  56 ++++++++++
 src/prd_pipeline/llm.py                            |  17 +++
 src/prd_pipeline/stages/__init__.py                |   0
 src/prd_pipeline/stages/requirements/__init__.py   |   0
 src/prd_pipeline/stages/requirements/models.py     |  20 ++++
 src/prd_pipeline/stages/requirements/stage.py      |  34 ++++++
 src/prd_pipeline/stages/requirements/writer.py     |  45 ++++++++
 tests/test_cli.py                                  |  49 +++++++++
 tests/test_llm.py                                  |  40 ++++++++
 tests/test_requirements_models.py                  |  36 +++++++
 tests/test_requirements_stage.py                   |  91 ++++++++++++++++
 tests/test_requirements_writer.py                  |  53 ++++++++++
 28 files changed, 873 insertions(+), 1 deletion(-)
```

# Usage for single PRD page

```
With gemini-3.8-flash:
Usage: {'input_tokens': 1452, 'output_tokens': 3109, 'total_tokens': 4561, 'input_token_details': {}, 'output_token_details': {'reasoning': 1797}}

Found open questions.

With default:
Usage: {'input_tokens': 1244, 'output_tokens': 706, 'total_tokens': 1950, 'input_token_details': {'audio': 0, 'cache_read': 0}, 'output_token_details': {'audio': 0, 'reasoning': 0}}

Did not find open questions.
```

# Reflect

1. Spec
2. Tests and touched files. Comprehensive testing is vital for any software so having those in the spec is important for longer projects. A high number of touched files increases the size of the project which raises the difficulty of additional changes later on.
3. The token usage in Logging.

# Baseline code

```python
"""Pipeline — Stage 1: PRD → structured requirements."""

  

import json

import os

from pathlib import Path

from typing import List, Optional

  

from dotenv import load_dotenv

from langchain_openai import AzureChatOpenAI

from pydantic import BaseModel, Field

  

load_dotenv()

  

PRD_PATH = Path("prd/notification-policy.md")

OUT_PATH = Path("out/requirements.json")

  
  

class Requirement(BaseModel):

    id: str = Field(description="Identifier such as FR-1 or NFR-2")

    title: str = Field(description="Short noun-phrase title")

    description: str = Field(description="Full requirement text")

    acceptance_criteria: Optional[List[str]] = Field(

        default=None,

        description="Concrete, testable criteria if determinable from the PRD",

    )

  
  

class AcceptanceExample(BaseModel):

    id: str

    scenario: str

    expected_action: str

    channel: Optional[str] = None

    reason_code: Optional[str] = None

  
  

class StructuredRequirements(BaseModel):

    product_name: str

    version: str

    goals: List[str]

    non_goals: List[str]

    functional_requirements: List[Requirement]

    non_functional_requirements: List[Requirement]

    acceptance_examples: List[AcceptanceExample]

    open_questions: List[str]

  
  

SYSTEM_PROMPT = (

    "You are a requirements analyst. Extract all requirements from the provided "

    "Product Requirements Document into the structured format exactly as specified. "

    "Preserve every functional and non-functional requirement, goal, non-goal, "

    "acceptance example, and open question. Do not invent or omit anything."

)

  
  

def build_llm() -> AzureChatOpenAI:

    return AzureChatOpenAI(

        azure_endpoint=os.environ["DIAL_URL"],

        azure_deployment=os.environ["DIAL_DEPLOYMENT"],

        api_key=os.environ["DIAL_API_KEY"],

        api_version=os.environ["DIAL_API_VERSION"],

        temperature=0,

    )

  
  

def extract_requirements(prd_text: str) -> StructuredRequirements:

    llm = build_llm()

    structured_llm = llm.with_structured_output(StructuredRequirements)

    messages = [

        ("system", SYSTEM_PROMPT),

        ("human", f"PRD to analyse:\n\n{prd_text}"),

    ]

    return structured_llm.invoke(messages)

  
  

def main() -> None:

    prd_text = PRD_PATH.read_text(encoding="utf-8")

  

    print(f"Reading PRD from {PRD_PATH} …")

    result = extract_requirements(prd_text)

  

    OUT_PATH.parent.mkdir(parents=True, exist_ok=True)

    OUT_PATH.write_text(

        json.dumps(result.model_dump(), indent=2, ensure_ascii=False),

        encoding="utf-8",

    )

  

    fr = len(result.functional_requirements)

    nfr = len(result.non_functional_requirements)

    print(f"Written {OUT_PATH}  ({fr} functional, {nfr} non-functional requirements)")

  
  

if __name__ == "__main__":

    main()
```