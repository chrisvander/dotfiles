## Code style

- Prefer the smallest clear implementation that fully solves the problem.
- Reduce concepts, indirection, configuration, and lines of code whenever practical.
- Prefer functional composition, pure functions, and immutable data over classes, inheritance, and mutable state.
- Use early returns and guard clauses to keep control flow flat.
- Abstract only when it clarifies a stable domain concept, meaningfully removes duplication, or simplifies callers.
- Keep related behavior, types, helpers, and tests together in cohesive modules with clear responsibilities.
- Prefer language and framework capabilities over custom infrastructure.
- Add mature dependencies selectively when they reliably solve substantial, general-purpose problems outside the app’s domain—such as parsing, dates, serialization, validation, retries, or cryptography.
- Reuse existing project patterns before introducing new ones.
- Make invalid states unrepresentable. Parse and validate data at system boundaries, then use types and data structures that preserve those guarantees internally.
- Handle errors explicitly and preserve useful context.
- Prefer descriptive names and obvious code over comments or cleverness. Comments should explain intent, constraints, or surprising decisions.
- Test observable behavior and important edge cases without coupling tests unnecessarily to implementation details.
- Keep changes focused, but simplify nearby code when doing so directly supports the change.
- Do not preserve backward compatibility by default when the project controls the specification and all callers can be updated.
- Remove obsolete code, unused abstractions, compatibility layers, and unnecessary dependencies.
- When approaches are otherwise comparable, prefer the one with less code and fewer concepts.

## Implementation approach

Before adding code:

1. Look for something that can be reused, simplified, or deleted.
2. Check whether the language, framework, or a trusted dependency already solves the problem.
3. Choose the smallest coherent change.
4. Call out meaningful assumptions or tradeoffs.

After implementing:

1. Run the relevant tests and checks.
2. Look for code, abstractions, or compatibility logic that can now be removed.
3. Summarize the change and anything that was not verified.

## Version control

- Prefer Jujutsu (`jj`) as my primary VCS interface.
- Use `jj status`, `jj diff`, `jj log`, `jj show`, `jj describe`, `jj new`, and `jj squash` for normal repository work.
- Use Git only when I explicitly request Git interoperability or a tool requires it.
