#!/usr/bin/env bash
# detect-test-setup.sh — find this repository's test framework and run command.
# Part of the test-changes skill. Run from the repository root.
#
# Prints two lines on success:
#   framework: <name>
#   command:   <command>
# Exits 0 when detected, 1 when unknown (the agent must then ask a human),
# 2 on misuse.
set -eu

if [ ! -e .git ]; then
  echo "⚠️  No .git found here — run this from the repository root." >&2
fi

report() { # report <framework> <command>
  echo "framework: $1"
  echo "command:   $2"
  exit 0
}

# --- JavaScript / TypeScript ------------------------------------------------
if [ -f package.json ]; then
  if grep -q '"test"[[:space:]]*:' package.json; then
    runner="npm test"
    if [ -f pnpm-lock.yaml ]; then runner="pnpm test"; fi
    if [ -f yarn.lock ]; then runner="yarn test"; fi
    fw="npm test script"
    if grep -q '"vitest"' package.json; then fw="vitest"; fi
    if grep -q '"jest"' package.json; then fw="jest"; fi
    if grep -q '"mocha"' package.json; then fw="mocha"; fi
    report "$fw" "$runner"
  fi
fi

# --- Python -------------------------------------------------------------------
if grep -qs pytest pyproject.toml pytest.ini setup.cfg tox.ini 2>/dev/null; then
  report "pytest" "pytest"
fi
if [ -d tests ] && ls tests/test_*.py >/dev/null 2>&1; then
  report "pytest (inferred from tests/ layout)" "pytest"
fi

# --- Go -----------------------------------------------------------------------
if [ -f go.mod ]; then
  report "go test" "go test ./..."
fi

# --- .NET ---------------------------------------------------------------------
dotnet_hit=$(find . -maxdepth 3 \( -name node_modules -o -name .git \) -prune \
  -o \( -name '*.sln' -o -name '*.csproj' \) -print 2>/dev/null | head -1)
if [ -n "$dotnet_hit" ]; then
  report "dotnet test" "dotnet test"
fi

# --- JVM ----------------------------------------------------------------------
if [ -f pom.xml ]; then
  report "Maven (JUnit/Surefire)" "mvn test"
fi
if [ -f build.gradle ] || [ -f build.gradle.kts ]; then
  if [ -x gradlew ]; then
    report "Gradle" "./gradlew test"
  fi
  report "Gradle" "gradle test"
fi

# --- Rust ---------------------------------------------------------------------
if [ -f Cargo.toml ]; then
  report "cargo test" "cargo test"
fi

# --- Ruby ---------------------------------------------------------------------
if [ -f Gemfile ]; then
  if grep -q rspec Gemfile; then
    report "RSpec" "bundle exec rspec"
  fi
  if [ -f Rakefile ]; then
    report "Rake (Minitest?)" "bundle exec rake test"
  fi
fi

# --- Elixir -------------------------------------------------------------------
if [ -f mix.exs ]; then
  report "ExUnit" "mix test"
fi

echo "framework: unknown" >&2
echo "No known test setup detected. Ask the human for the test command." >&2
exit 1
