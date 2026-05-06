#!/usr/bin/env bash
# =============================================================================
# Batch Create GitHub Issues from docs/tickets/
# =============================================================================
# Usage: ./.github/scripts/create-issues.sh
#
# Prerequisites:
#   - GitHub CLI (gh) authenticated with repo write access
#   - Run from the repository root
#
# This script creates GitHub Issues for all CHOP tickets (001-020) defined
# in the docs/tickets/ folder. Each issue is labeled by priority and type.
# =============================================================================

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"

# Ensure labels exist (idempotent)
ensure_label() {
    local name="$1" color="$2" description="$3"
    gh label create "$name" --color "$color" --description "$description" 2>/dev/null || true
}

echo "==> Ensuring labels exist..."
ensure_label "P0-critical"     "d73a4a" "Ship-blocking: thread safety, race conditions, correctness"
ensure_label "P1-major"        "e99695" "Major performance: GC pressure, boxing, O(N²) algorithms"
ensure_label "P2-moderate"     "f9d0c4" "Moderate improvements: caching, cleanup, readonly structs"
ensure_label "P3-minor"        "fef2c0" "Minor: code cleanup, documentation, dead code removal"
ensure_label "bug"             "d73a4a" "Something isn't working"
ensure_label "performance"     "0075ca" "Performance improvement"
ensure_label "thread-safety"   "b60205" "Thread safety / concurrency issue"
ensure_label "code-cleanup"    "c5def5" "Code cleanup and simplification"
ensure_label "documentation"   "0075ca" "Documentation improvements"
ensure_label "dependencies"    "0e8a16" "Native/Dependencies component"
ensure_label "messages"        "1d76db" "Native/Messages component"
ensure_label "unity"           "5319e7" "Unity integration component"

create_issue() {
    local title="$1" body="$2" labels="$3"
    echo "  Creating: $title"
    gh issue create --title "$title" --body "$body" --label "$labels"
}

echo ""
echo "==> Creating CHOP issues..."

# ---------------------------------------------------------------------------
# CHOP-001: Pool SequentialHandlingPromiseSource
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-001: Pool SequentialHandlingPromiseSource to eliminate GC pressure" \
    "## Priority: 🔴 P0 — Critical
## Type: Performance / GC Optimization
## Component: Native/Messages

### Problem
\`SequentialHandlingPromiseSource\` is allocated on every message dispatch via \`new\` in \`BaseMulticastHandler.InitiateWithSource()\`. At 60fps with multiple message types, this creates significant GC pressure with frequent Gen0 collections visible in Unity Profiler.

### Solution
Create an \`ObjectPool<SequentialHandlingPromiseSource>\` that rents/returns sources instead of allocating. Add \`IResettable\` interface and \`Reset()\` method to clear state between uses.

### Acceptance Criteria
- [ ] Zero allocations per dispatch in steady state
- [ ] Pool correctly resets sources between uses
- [ ] Thread-safe rent/return
- [ ] All existing tests pass

### Dependencies
- Blocked by CHOP-014 (IDisposable on IHandlingPromiseSource)

📄 **Full spec:** [\`docs/tickets/001-pool-promise-sources.md\`](docs/tickets/001-pool-promise-sources.md)" \
    "P0-critical,performance,messages"

# ---------------------------------------------------------------------------
# CHOP-002: Cache RegisteredMessageHandlers Array
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-002: Cache RegisteredMessageHandlers array (copy-on-write)" \
    "## Priority: 🔴 P0 — Critical
## Type: Performance / GC Optimization
## Component: Native/Messages/Registration

### Problem
\`RegisteredMessageHandlers\` property uses spread operator \`[.. _registeredMessageHandlers]\` creating a new array on every access. Called on every message dispatch — 60 array allocations/sec per message type at 60fps.

### Solution
Cache the array in a \`volatile\` field. Rebuild only on register/deregister (copy-on-write). Dispatch reads the cached field (zero allocation).

### Acceptance Criteria
- [ ] Zero allocations during message dispatch
- [ ] Cache rebuilt only on mutation
- [ ] Volatile ensures cross-thread visibility
- [ ] All existing tests pass

### Dependencies
- Subsumed by CHOP-005

📄 **Full spec:** [\`docs/tickets/002-cache-handler-array.md\`](docs/tickets/002-cache-handler-array.md)" \
    "P0-critical,performance,messages"

# ---------------------------------------------------------------------------
# CHOP-003: Thread-Safe SingletonResolution.Get()
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-003: Thread-safe SingletonResolution.Get()" \
    "## Priority: 🔴 P0 — Critical
## Type: Bug / Thread Safety
## Component: Native/Dependencies/Resolutions

### Problem
\`SingletonResolution.Get()\` uses \`??=\` which is NOT atomic. Under concurrent access, two threads can both observe \`_instance\` as null, both invoke the factory, and create two instances of a \"singleton.\" The second overwrites the first — the first leaks without disposal.

\`\`\`csharp
// Current code — RACE CONDITION
public override object? Get(IDependencyContainer container) =>
    _instance ??= Factory?.Invoke(container);
\`\`\`

### Solution
Implement lock-based double-checked locking with a \`_isCreated\` flag for a fast path that avoids lock acquisition after initialization.

### Acceptance Criteria
- [ ] Singleton created exactly once under concurrent access
- [ ] Factory invoked at most once
- [ ] Fast path (after creation) requires no lock
- [ ] Dispose properly cleans up singleton instance
- [ ] All existing tests pass

📄 **Full spec:** [\`docs/tickets/003-singleton-thread-safety.md\`](docs/tickets/003-singleton-thread-safety.md)" \
    "P0-critical,bug,thread-safety,dependencies"

# ---------------------------------------------------------------------------
# CHOP-004: Thread-Safe ContainedResolution.Get()
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-004: Thread-safe ContainedResolution.Get()" \
    "## Priority: 🔴 P0 — Critical
## Type: Bug / Thread Safety
## Component: Native/Dependencies/Resolutions

### Problem
\`ContainedResolution.Get()\` uses an unsynchronized \`Dictionary<IDependencyContainer, object>\`. Concurrent read/write operations can corrupt the dictionary's internal hash table — causing infinite loops, lost entries, or \`IndexOutOfRangeException\`.

### Solution
Replace \`Dictionary\` with \`ConcurrentDictionary\` and use \`GetOrAdd\` for atomic lookup-or-create semantics.

### Acceptance Criteria
- [ ] Per-container instance isolation preserved
- [ ] No dictionary corruption under concurrent access
- [ ] Thread-safe Dispose and DisposeFor
- [ ] All existing tests pass

📄 **Full spec:** [\`docs/tickets/004-contained-thread-safety.md\`](docs/tickets/004-contained-thread-safety.md)" \
    "P0-critical,bug,thread-safety,dependencies"

# ---------------------------------------------------------------------------
# CHOP-005: Fix Race Condition — Handler Registration vs Dispatch
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-005: Fix race condition — handler registration vs dispatch" \
    "## Priority: 🔴 P0 — Critical
## Type: Bug / Thread Safety
## Component: Native/Messages/Registration

### Problem
\`BaseMessageHandlerRegistrar\` has a \`List<T>\` that is mutated during registration and read during dispatch with zero synchronization. \`List<T>.Add()\` may trigger a resize while another thread iterates, \`Sort()\` reorders during copy, and \`Remove()\` shifts elements during reads.

### Solution
Lock all mutations to the handler list. After mutation, atomically publish a new snapshot array via a \`volatile\` field. Dispatch reads the volatile snapshot — no lock needed.

### Acceptance Criteria
- [ ] Registration during dispatch doesn't corrupt state
- [ ] Dispatch path acquires NO locks (volatile read only)
- [ ] In-flight dispatches use snapshot semantics
- [ ] All existing tests pass

### Dependencies
- Subsumes CHOP-002

📄 **Full spec:** [\`docs/tickets/005-registration-dispatch-race.md\`](docs/tickets/005-registration-dispatch-race.md)" \
    "P0-critical,bug,thread-safety,messages"

# ---------------------------------------------------------------------------
# CHOP-006: Fix Shared Mutable State in Static Sources
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-006: Fix shared mutable state in HandlingResultPromise static sources" \
    "## Priority: 🔴 P0 — Critical
## Type: Bug / Race Condition
## Component: Native/Messages

### Problem
\`HandlingResultPromise.NoHandlers\` and \`.Success\` share static \`IHandlingPromiseSource\` instances with mutable callback properties. Two callers using the same static promise can overwrite each other's callbacks.

### Solution
Create an \`ImmutablePromiseSource\` that silently ignores callback mutations. Use it for the static fields so callbacks are always invoked inline (the source is already completed).

### Acceptance Criteria
- [ ] Static promises return correct status
- [ ] Concurrent callback setting doesn't interfere between callers
- [ ] Zero allocation for static promise access
- [ ] All existing tests pass

📄 **Full spec:** [\`docs/tickets/006-shared-static-sources.md\`](docs/tickets/006-shared-static-sources.md)" \
    "P0-critical,bug,thread-safety,messages"

# ---------------------------------------------------------------------------
# CHOP-007: Generic DependencyResolution<T>
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-007: Generic DependencyResolution<T> to eliminate boxing" \
    "## Priority: 🟠 P1 — Major Performance
## Type: Performance
## Component: Native/Dependencies/Resolutions

### Problem
All dependency resolution returns \`object?\`, boxing value types on every resolve. For frequently-resolved value-type dependencies, this creates unnecessary GC pressure.

### Solution
Add generic \`Resolve<T>\` path with \`ITypedResolution<T>\` interface alongside existing non-generic resolution.

### Acceptance Criteria
- [ ] Value type dependencies resolved without boxing
- [ ] Reference type resolution unchanged
- [ ] Backward compatible with existing API
- [ ] All existing tests pass

📄 **Full spec:** [\`docs/tickets/007-generic-resolution-no-boxing.md\`](docs/tickets/007-generic-resolution-no-boxing.md)" \
    "P1-major,performance,dependencies"

# ---------------------------------------------------------------------------
# CHOP-008: Replace yield return with Concrete Collections
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-008: Replace yield return with concrete collections" \
    "## Priority: 🟠 P1 — Major Performance
## Type: Performance
## Component: Native

### Problem
Five methods use \`yield return\` which allocates enumerator state machines on each call, including \`HandlingResult.Exceptions\`, \`ResolveAll\`, and \`GetResolutions\`.

### Solution
Replace with direct \`List<T>\`, array returns, or struct enumerators.

### Acceptance Criteria
- [ ] No enumerator state machine allocations
- [ ] Identical behavior for all callers
- [ ] All existing tests pass

📄 **Full spec:** [\`docs/tickets/008-replace-yield-return.md\`](docs/tickets/008-replace-yield-return.md)" \
    "P1-major,performance"

# ---------------------------------------------------------------------------
# CHOP-009: Eliminate Lambda Closure Allocations
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-009: Eliminate lambda closure allocations in registration extensions" \
    "## Priority: 🟠 P1 — Major Performance
## Type: Performance
## Component: Native/Dependencies

### Problem
Registration extension methods capture variables in lambda closures, allocating a closure object per registration call.

### Solution
Implement \`DirectInstanceResolution\` for pre-built instances to avoid wrapper lambdas.

### Acceptance Criteria
- [ ] Zero closure allocations for instance registration
- [ ] Factory registration still works correctly
- [ ] All existing tests pass

📄 **Full spec:** [\`docs/tickets/009-lambda-closure-allocations.md\`](docs/tickets/009-lambda-closure-allocations.md)" \
    "P1-major,performance,dependencies"

# ---------------------------------------------------------------------------
# CHOP-010: Fix Double Dictionary Lookup in Deregister
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-010: Fix double dictionary lookup in Deregister" \
    "## Priority: 🟠 P1 — Major Performance
## Type: Performance
## Component: Native/Dependencies

### Problem
\`Deregister()\` performs \`ContainsKey\` then indexer access — two dictionary lookups that hash the key twice.

### Solution
Replace with single \`TryGetValue\` call.

### Acceptance Criteria
- [ ] Single dictionary lookup per deregister
- [ ] Identical behavior
- [ ] All existing tests pass

📄 **Full spec:** [\`docs/tickets/010-deregister-double-lookup.md\`](docs/tickets/010-deregister-double-lookup.md)" \
    "P1-major,performance,dependencies"

# ---------------------------------------------------------------------------
# CHOP-011: Replace Full Sort with Insertion-Point Binary Search
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-011: Replace full Sort with insertion-point binary search" \
    "## Priority: 🟠 P1 — Major Performance
## Type: Performance
## Component: Native/Messages/Registration

### Problem
Handler registration calls \`List.Sort()\` O(n log n) after every \`Add()\`. The list is already sorted — only the insertion point matters.

### Solution
Use \`List.BinarySearch\` O(log n) to find insertion point, then \`Insert\` O(n).

### Acceptance Criteria
- [ ] Handlers correctly ordered after insertion
- [ ] 3-5x improvement for large handler lists
- [ ] All existing tests pass

📄 **Full spec:** [\`docs/tickets/011-sort-on-registration.md\`](docs/tickets/011-sort-on-registration.md)" \
    "P1-major,performance,messages"

# ---------------------------------------------------------------------------
# CHOP-012: Fix O(N²) Allocation in MergeExceptions
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-012: Fix O(N²) allocation in MergeExceptions" \
    "## Priority: 🟠 P1 — Major Performance
## Type: Performance
## Component: Native/Messages

### Problem
Exception merging during sequential handling repeatedly concatenates arrays, creating O(N²) total allocations.

### Solution
Accumulate exceptions in a \`List<Exception>\` during handling, build the final array once.

### Acceptance Criteria
- [ ] Exception merging is O(N)
- [ ] All exceptions still reported correctly
- [ ] All existing tests pass

📄 **Full spec:** [\`docs/tickets/012-merge-exceptions-quadratic.md\`](docs/tickets/012-merge-exceptions-quadratic.md)" \
    "P1-major,performance,messages"

# ---------------------------------------------------------------------------
# CHOP-013: Cache OnValidate Parent Hierarchy Lookups
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-013: Cache OnValidate parent hierarchy lookups" \
    "## Priority: 🟡 P2 — Moderate
## Type: Performance
## Component: Unity

### Problem
\`BaseMonoContainer.OnValidate()\` calls \`GetComponentInParent\` on every property change/recompilation — expensive for deep hierarchies.

### Solution
Cache parent hierarchy lookup results with a dirty flag.

### Acceptance Criteria
- [ ] Parent lookup cached after first call
- [ ] Cache invalidated on hierarchy change
- [ ] All existing tests pass

📄 **Full spec:** [\`docs/tickets/013-unity-onvalidate-perf.md\`](docs/tickets/013-unity-onvalidate-perf.md)" \
    "P2-moderate,performance,unity"

# ---------------------------------------------------------------------------
# CHOP-014: Add IDisposable to IHandlingPromiseSource
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-014: Add IDisposable to IHandlingPromiseSource interface" \
    "## Priority: 🟡 P2 — Moderate
## Type: Enhancement
## Component: Native/Messages

### Problem
\`IHandlingPromiseSource\` lacks \`IDisposable\`, preventing pooling and proper resource cleanup through interface references. Blocks CHOP-001.

### Solution
Extend \`IHandlingPromiseSource\` to implement \`IDisposable\`.

### Acceptance Criteria
- [ ] Interface extends IDisposable
- [ ] Double-dispose is safe
- [ ] All existing tests pass

📄 **Full spec:** [\`docs/tickets/014-idisposable-promise-source.md\`](docs/tickets/014-idisposable-promise-source.md)" \
    "P2-moderate,messages"

# ---------------------------------------------------------------------------
# CHOP-015: Make HandlingResultPromise a readonly struct
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-015: Make HandlingResultPromise a readonly struct" \
    "## Priority: 🟡 P2 — Moderate
## Type: Performance
## Component: Native/Messages

### Problem
\`HandlingResultPromise\` is a mutable struct with immutable semantics. Missing \`readonly\` keyword prevents JIT optimizations.

### Solution
Add \`readonly\` modifier to the struct declaration.

### Acceptance Criteria
- [ ] Struct declared as \`readonly\`
- [ ] JIT can inline struct methods
- [ ] All existing tests pass

📄 **Full spec:** [\`docs/tickets/015-readonly-struct-promise.md\`](docs/tickets/015-readonly-struct-promise.md)" \
    "P2-moderate,performance,messages"

# ---------------------------------------------------------------------------
# CHOP-016: Add OnDestroy Cleanup to BaseMonoDependent
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-016: Add OnDestroy cleanup to BaseMonoDependent" \
    "## Priority: 🟡 P2 — Moderate
## Type: Bug / Memory Leak
## Component: Unity

### Problem
\`BaseMonoDependent\` never clears its container reference in \`OnDestroy()\`, preventing GC of destroyed MonoBehaviours.

### Solution
Add \`OnDestroy()\` to null out the container reference.

### Acceptance Criteria
- [ ] Container reference cleared on destroy
- [ ] No memory leaks
- [ ] All existing tests pass

📄 **Full spec:** [\`docs/tickets/016-mono-dependent-cleanup.md\`](docs/tickets/016-mono-dependent-cleanup.md)" \
    "P2-moderate,bug,unity"

# ---------------------------------------------------------------------------
# CHOP-017: Convert HandlingResult Static Properties to Fields
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-017: Convert HandlingResult static properties to static readonly fields" \
    "## Priority: 🟡 P2 — Moderate
## Type: Performance
## Component: Native/Messages

### Problem
\`HandlingResult.Cancelled\`, \`.NoHandlers\`, and \`.Success\` are expression-bodied properties. JIT cannot inline them as constants.

### Solution
Convert from \`=>\` properties to \`=\` static readonly fields.

### Acceptance Criteria
- [ ] Static members are fields, not properties
- [ ] Values identical to previous
- [ ] All existing tests pass

📄 **Full spec:** [\`docs/tickets/017-handling-result-static-fields.md\`](docs/tickets/017-handling-result-static-fields.md)" \
    "P2-moderate,performance,messages"

# ---------------------------------------------------------------------------
# CHOP-018: Remove Redundant HandlePromiseSource
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-018: Remove redundant HandlePromiseSource wrapper" \
    "## Priority: 🟢 P3 — Minor
## Type: Code Cleanup
## Component: Native/Messages

### Problem
\`HandlePromiseSource\` wraps \`IHandlingPromiseSource\` and just delegates all calls without any transformation — pure indirection.

### Solution
Delete \`HandlePromiseSource.cs\` and use inner source directly.

### Acceptance Criteria
- [ ] File deleted
- [ ] No references remain
- [ ] All tests pass

📄 **Full spec:** [\`docs/tickets/018-remove-handle-promise-source.md\`](docs/tickets/018-remove-handle-promise-source.md)" \
    "P3-minor,code-cleanup,messages"

# ---------------------------------------------------------------------------
# CHOP-019: Remove Empty Foundation Project
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-019: Remove empty Foundation project" \
    "## Priority: 🟢 P3 — Minor
## Type: Code Cleanup
## Component: Native/Foundation

### Problem
The Foundation project contains only an empty \`ExampleClass\`. It adds build time and confusion.

### Solution
Remove \`Native/Foundation/\` directory and all solution/project references.

### Acceptance Criteria
- [ ] Directory removed
- [ ] No orphan references
- [ ] Build succeeds

📄 **Full spec:** [\`docs/tickets/019-remove-empty-foundation.md\`](docs/tickets/019-remove-empty-foundation.md)" \
    "P3-minor,code-cleanup"

# ---------------------------------------------------------------------------
# CHOP-020: Standardize XML Documentation
# ---------------------------------------------------------------------------
create_issue \
    "CHOP-020: Standardize XML documentation across public APIs" \
    "## Priority: 🟢 P3 — Minor
## Type: Documentation
## Component: All

### Problem
XML documentation coverage is inconsistent across public APIs, leading to incomplete IntelliSense.

### Solution
Add complete XML docs to all public types and members following the existing style.

### Acceptance Criteria
- [ ] All public types have \`<summary>\` docs
- [ ] All public methods fully documented
- [ ] No CS1591 warnings when doc generation enabled
- [ ] Style consistent with existing docs

📄 **Full spec:** [\`docs/tickets/020-xml-documentation-consistency.md\`](docs/tickets/020-xml-documentation-consistency.md)" \
    "P3-minor,documentation"

echo ""
echo "==> All 20 CHOP issues created successfully!"
echo ""
echo "Run 'gh issue list' to verify."
