---
name: structural-invariants
description: Design and review APIs, data models, and state machines so invalid states cannot be constructed. Use when replacing assertion-heavy logic, reviewing require/assert/unwrap guards, reducing invalid combinations of flags and optional fields, or constraining lifecycle transitions. Apply to internal invariants, not as a blanket removal of input validation, concurrency checks, or test assertions.
---

# Structural invariants

Make the invalid operation unavailable, rather than accepting it and rejecting it later. Prefer the smallest representation that preserves the invariant. Fewer methods or fewer assertions alone do not mean a simpler design.

## Review the whole invariant

1. Read the model, operations, callers, adapters, and relevant tests before changing code. Respect an analysis-only request.
2. Inventory assertions, `require` helpers, guard errors, `unwrap`/`expect`, unchecked indexing, and comments that assume an invariant. If asked to review all assertions, account for every site in scope, including checks that should remain.
3. For each check, state the invariant and how the invalid state enters the system. Classify it as an internal construction problem, an external boundary check, or a fact that can change concurrently.
4. Look first for fields, states, parameters, or operations that can be removed or derived. Then consider a closed union, private constructor, scoped operation, or state-specific capability.
5. Trace the proposed guarantee through construction, mutation, deserialization, persistence, cloning, and concurrent use. Explain what remains a runtime check.

For a review, use a compact table: **check/location → invalid construction → structural change → remaining runtime check**. Group duplicates without omitting sites. Implement only when the request includes implementation.

## Prefer these structural changes

| Current shape | Prefer |
| --- | --- |
| Independent flags, nullable fields, and status tags with forbidden combinations | A closed union whose variants contain exactly their required data; derive redundant flags |
| One command accepting every lifecycle state | Operations exposed only on the states where they are legal |
| Caller supplies several values that must agree | Derive them from one validated value or coherent snapshot |
| Arbitrary ID plus unrelated record, repository, or destination | An operation scoped to the owning record or repository |
| New input contains persisted status, receipt, or settlement fields | An intent type; let the owner create lifecycle metadata |
| Retry accepts the same ID with a different payload | Allocate identity once and retain the immutable request for retries |
| Separate updates can leave references dangling | One domain operation that atomically updates the dependent values |
| An open resource can still be mutated after completion | Completion consumes the open capability and returns the completed form |
| Caller chooses arbitrary old/new states | Named transitions that derive the next state and preserve fixed context |

Use ordinary language features first. Private fields and a small enum may be enough. Introduce typestate, branded IDs, or lifetime machinery only when they remove more complexity than they add across callers, adapters, and tests. Do not create a generic state-machine framework for a few transitions.

Moving the same assertion into a constructor is not sufficient. The constructor should derive coupled values or expose only valid choices. Boundary constructors may still validate untrusted input.

## Example: prepared writes cannot be settled

This API permits an invalid request:

```rust
fn settle(write: &mut Write) -> Result<()> {
    require(!matches!(write.publication, Publication::Prepared(_)))?;
    // ...
}
```

Instead, expose a small lifecycle with private representations:

```text
LocalWrite.prepare(preconditions) -> PreparedWrite
LocalWrite.settle()               -> RetainedWrite
PreparedWrite.acknowledge(receipt)-> AcceptedWrite
PreparedWrite.reconcile(evidence) -> reconciliation outcome
AcceptedWrite.retire(observation) -> RetainedWrite
```

`PreparedWrite` has no settlement operation. Acknowledgment preserves the prepared request's identity and preconditions. Reconciliation must establish what happened before returning a state that permits another action; it is not an unchecked conversion back to `LocalWrite`.

These can be variants or views of one durable write, not separate tables. Consume lifecycle capabilities where appropriate and avoid `Clone` when it would defeat that guarantee. Across storage calls, bind changes to the owning repository and read revision; keep the conditional commit so stale capabilities cannot change current state.

## Keep checks for facts types cannot establish

- Validate network, file, FFI, and persisted input before producing trusted internal values. Reconstruct lifecycle capabilities through that boundary, not unchecked deserialization.
- Keep authorization, integrity, and origin checks where trust boundaries require them. A typed ID alone does not prove ownership or authorization.
- Keep revision checks and atomic commits for concurrent clients, browser tabs, and processes. Ownership in one process does not prevent another process from changing durable state.
- Handle I/O failures, resource limits, overflow, and remote outcomes explicitly. Typestate cannot prove a timed-out request was rejected.
- Retain useful test assertions. Keep internal assertions only for invariants that cannot reasonably be encoded; explain why and do not substitute a panic for a recoverable external error.

## Verify and simplify

- Show why the formerly invalid request is no longer expressible through the supported API. Use a focused compile-fail/type-check test when it protects a meaningful public restriction.
- Test valid transitions and retained evidence, plus remaining boundary failures, stale revisions, and atomic failure behavior as applicable.
- Remove obsolete validation branches, duplicate status fields, and misuse tests made impossible by construction. Keep tests for runtime failure modes.
- Run the relevant project checks. Report the structural guarantee, remaining runtime obligations, and anything unverified.

Judge the result by fewer representable invalid combinations and fewer concepts across the whole implementation. Honor the project's scope and size constraints; do not replace a short assertion with an elaborate framework.
