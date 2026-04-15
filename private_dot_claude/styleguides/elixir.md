# Elixir Style Guide

Derived from the grpc-client codebase. Follow these rules in all new Elixir code regardless of project.

---

## Module Structure

### GenServer: Server / Implementation / API split

Every GenServer is split into three modules:

```
lib/sim_orchestrator/heartbeat_monitor/
  server.ex          # GenServer callbacks + State struct
  implementation.ex  # Pure functions, no process state
  api.ex             # Public-facing calls/casts
```

- **Server**: GenServer callbacks only. Delegates business logic to Implementation. Holds State.
- **Implementation**: Pure functions. No `GenServer.call`, no side effects beyond what's passed in. Fully unit-testable.
- **API**: `call/cast` wrappers. Validates input with `with` chains before sending to the GenServer. May be inlined into Server only when state is trivially small (< 3 fields).

If the module writes to Redis, add a fourth module:

```
  storage.ex         # Redis reads/writes, namespaced under this server's keyspace
```

### State as a nested defmodule

```elixir
defmodule Server do
  use GenServer

  defmodule State do
    @type t :: %__MODULE__{
      pods: map(),
      run_id: String.t() | nil
    }
    defstruct pods: %{}, run_id: nil
  end
end
```

Nested structs (e.g. sub-objects within State) each get their own `defmodule` inside `State`:

```elixir
defmodule State do
  defmodule Channel do
    defstruct [:id, :conn]
    @type t :: %__MODULE__{id: String.t(), conn: pid()}
  end

  defstruct channels: []
  @type t :: %__MODULE__{channels: [Channel.t()]}
end
```

Use `DeriveAccess` (or `@derive {Access, keys: [...]}`) when the State struct needs to be accessed via `get_in/put_in/update_in`.

---

## Naming Conventions

| Prefix/Suffix | Meaning |
|---|---|
| `do_` | Private implementation of a public function |
| `maybe_` | Conditional action — may or may not do the thing |
| `handle_` | Handles a result or case, not a GenServer callback |
| `via_tuple/1` | Always private; returns `{:via, Registry, ...}` |

---

## Function Rules

### Single responsibility

Each function does one thing. Extract private helpers aggressively rather than nesting logic.

```elixir
# Bad
def assign_batch(state, pod_id, sims) do
  state
  |> Map.update!(:pods, fn pods ->
    Map.update!(pods, pod_id, fn pod ->
      %{pod | sims: pod.sims ++ sims, slots_used: pod.slots_used + length(sims)}
    end)
  end)
end

# Good
def assign_batch(state, pod_id, sims) do
  state
  |> update_pod(pod_id, &add_sims(&1, sims))
end

defp add_sims(pod, sims), do: %{pod | sims: pod.sims ++ sims, slots_used: pod.slots_used + length(sims)}
defp update_pod(state, pod_id, fun), do: update_in(state, [:pods, pod_id], fun)
```

### Prefer private functions over nested lambdas

Never write multi-line lambdas inline. Extract to a named private function.

### Pattern matching over `if`

```elixir
# Bad
def handle(status) do
  if status == :active do
    do_active()
  else
    do_idle()
  end
end

# Good
def handle(:active), do: do_active()
def handle(_status), do: do_idle()
```

### Multi-head functions over `case` on a single argument

```elixir
# Bad
def process(result) do
  case result do
    {:ok, val} -> handle_ok(val)
    {:error, reason} -> handle_error(reason)
  end
end

# Good
def process({:ok, val}), do: handle_ok(val)
def process({:error, reason}), do: handle_error(reason)
```

Use `case` only when matching on an *expression* (not a function argument) or when the arms have shared local bindings.

### Pipelines must be at least 2 steps

```elixir
# Good (2 steps)
value |> transform() |> validate()

# Good (3+ steps)
value
|> normalize()
|> transform()
|> validate()
```

2-step pipelines may stay on one line. 3+ steps go multi-line, one step per line.

---

## `with` Chains

Use `with` for sequential validation/operations where any step can fail. Each clause binds a result.

```elixir
def submit(params) do
  with {:ok, run_id} <- validate_run_id(params),
       {:ok, sims} <- validate_simulators(params),
       {:ok, _} <- Storage.write_run(run_id, sims) do
    {:ok, run_id}
  end
end
```

- If all errors should propagate unchanged, omit `else` entirely — implicit passthrough, not `else error -> error`.
- Only add `else` when different errors need different handling, and match each case explicitly:

```elixir
# Different errors, different handling → explicit else
with {:ok, pod} <- find_pod(pod_id),
     {:ok, batch} <- pop_batch(run_id) do
  assign(pod, batch)
else
  {:error, :pod_not_found} -> {:error, :no_accepting_pod}
  {:error, :no_batches_left} -> :ok
end

# All errors propagate → no else block
with {:ok, run_id} <- validate_run_id(params),
     {:ok, sims} <- validate_simulators(params),
     {:ok, _} <- Storage.write_run(run_id, sims) do
  {:ok, run_id}
end
```

---

## Aliases and Imports

Order: `require` → `import` → `alias`. Blank line between groups. One module per line, alphabetical within each group.

```elixir
require Logger

import SimOrchestrator.Guards, only: [is_valid_pod_id: 1]

alias SimOrchestrator.HeartbeatMonitor.Storage
alias SimOrchestrator.PodRegistry
alias SimOrchestrator.RunSupervisor
```

**Rules:**
- `import` is reserved for macros and guards only — never import plain functions.
- Always `import Mod, only: [...]` — never `import Mod` (no wildcard imports).
- Prefer `Alias.function(arg)` over importing a function.
- No `alias Foo.{Bar, Baz}` multi-alias syntax.

---

## Specs and Docs

- No `@spec` annotations. Functions are self-documenting through descriptive names, argument names, and variable names. Write English, not type signatures.
- `@type t` on struct modules — types are still useful for struct references.
- `@moduledoc` is optional. Use judgement:
  - **Skip it** for modules whose purpose is obvious from convention: state/struct definitions, model definitions, workflow (CRUD) modules, gRPC handler modules. These follow a known shape — there is nothing extra to say.
  - **Write it** for modules with domain-specific logic that isn't self-evident from the name: K8s management, state machine logic, anything where a reader unfamiliar with the domain would benefit from a one-liner explaining *what* and *why*.

---

## Module Attributes as Constants

Use module attributes for constants, timeouts, and configuration defaults:

```elixir
@heartbeat_interval_ms 30_000
@reassignment_timeout_s 300
@call_timeout 7_000
```

---

## GenServer Callbacks

Always annotate with `@impl GenServer`:

```elixir
@impl GenServer
def init(opts), do: ...

@impl GenServer
def handle_call({:assign, pod_id}, _from, state), do: ...
```

`start_link` always accepts an `opts` keyword list. Pattern match on meaningful keys at the head:

```elixir
def start_link([enabled: true] = opts), do: GenServer.start_link(__MODULE__, opts, name: via_tuple(opts))
def start_link(_opts), do: :ignore
```

---

## Supervisors

`child_spec` entries are explicit — no `use Supervisor` magic child_spec generation. Each child entry lists `id`, `start`, and `restart` explicitly when non-default.

---

## Tests

- `@subject ModuleName` at the top of each test file — reference the module under test via `@subject` throughout.
- `describe` blocks group related scenarios.
- `setup` blocks and `defp` helpers keep test bodies short and readable. When you read a test you should understand *what* it tests without needing to trace setup details — dig into helpers only when you need to.
- Each test tests exactly one thing. Don't combine state creation and a side effect (e.g. gRPC call) in a single test — write two.

### Assertions

Prefer strong equality for small, fully-known values:

```elixir
assert result == {:ok, %{pod_id: "pod-abc", status: :active}}
```

Use pattern matching when the result contains dynamic or untestable values (e.g. a `pid`, a `DateTime`, a generated ID):

```elixir
assert {:ok, %{inserted_at: inserted_at}} = @subject.create(params)
```

For time values, prefer static fixtures over `DateTime.utc_now()`. When dynamic time is unavoidable, use `assert_in_delta`:

```elixir
assert_in_delta DateTime.to_unix(result.timestamp), DateTime.to_unix(DateTime.utc_now()), 2
```

- Private helpers in test files use `defp`, named descriptively (e.g. `build_pod_state/1`, `take_channels_n_times/2`).
- No `assert_receive` with arbitrary timeouts — use explicit flush or synchronous calls.
- **Never use `Process.sleep/1` or `:timer.sleep/1`** anywhere — in logic or in tests. If you feel the urge to sleep, find a synchronous alternative: a direct call, a flush, a GenServer.call that acts as a barrier, or a test helper that waits on a condition via message passing.

---

## Redis / Storage Modules

- Each GenServer that owns Redis keys gets a sibling `Storage` module.
- Key-building functions are private to `Storage`, returning strings.
- No Redis calls outside of a `Storage` module.
- Key namespace matches the server's module hierarchy:

```
HeartbeatMonitor.Storage  → keys: pod:{pod_id}:last_heartbeat, pods:accepting, ...
SyncBarrier.Storage       → keys: run:{run_id}:barrier:*, run:{run_id}:status, ...
```

### Ownership rule

A Storage module is exclusively written to by its owning GenServer — no other process may write to its keys. Reads are technically allowed from outside, but the preferred path is through the owning process (via an API call) so that the owner remains the single source of truth for its state. Direct reads from outside the owner are a code smell; do it only when the performance cost of a round-trip is demonstrably unacceptable.

---

## Error Handling

- **Never raise** unless explicitly told to. Always prefer graceful error handling.
- Propagate errors up the call chain as `{:error, reason}`.
- `Logger.error` is called at the **top of the error path** — the outermost function that handles the error clause. If `f1` calls `f2` and both pattern-match on errors, only `f1` logs. Lower-level functions return `{:error, reason}` and let the caller decide whether to log.
- Log with all available context at the point of logging — include run_id, pod_id, reason, or whatever is in scope.

```elixir
# f2 — returns error, does NOT log
defp load_batch(pod_id) do
  case Storage.get_batch(pod_id) do
    {:ok, batch} -> {:ok, batch}
    {:error, reason} -> {:error, reason}
  end
end

# f1 — top of the error path, logs here
def assign(pod_id) do
  case load_batch(pod_id) do
    {:ok, batch} -> do_assign(batch)
    {:error, reason} ->
      Logger.error("Failed to assign batch", pod_id: pod_id, reason: reason)
      {:error, reason}
  end
end
```

---

## Logging

No interpolated strings. Always pass context as metadata keywords:

```elixir
Logger.info("Batch assigned", run_id: run_id, pod_id: pod_id, sim_count: length(sims))
Logger.error("Heartbeat missed", pod_id: pod_id, missed_count: count)
```

---

## Test Mocking

**Redis**: always tested raw — no mocks or stubs. Tests hit a real Redis instance.

**gRPC**: mocked with Mox. The pattern:

1. In `test/test_helper.exs`, declare a mock for every gRPC service using the protobuf-generated `Service` module as the behaviour:

```elixir
Mox.defmock(SimOrchestrator.Mocks.GRPC, for: GRPCClient)
Mox.defmock(SimOrchestrator.Mocks.ECSIMService, for: CPSIM.GRPC.SimOrchestrator.ECSIM.Service)
```

2. In `test/support/helpers/grpc.ex`, provide a `mock_grpc_chan/1` helper that stubs the channel pool:

```elixir
def mock_grpc_chan(count \\ 1) do
  SimOrchestrator.Mocks.GRPC
  |> stub(:child_spec, fn _opts -> %{id: SimOrchestrator.Mocks.GRPC, start: {Kernel, :., [fn -> :ignore end, []]}} end)
  |> expect(:with_chan, count, fn _service_atom, callback -> callback.(%GRPC.Channel{}) end)
end
```

3. In each test file, call `mock_grpc_chan()` in `setup` and set expectations per RPC method. Encode/decode the response through protobuf to catch serialization bugs:

```elixir
setup :verify_on_exit!
setup do: mock_grpc_chan()

defp mock_ecsim_call(response, action) do
  actual_response =
    response
    |> response.__struct__.encode()
    |> response.__struct__.decode()

  expect(SimOrchestrator.Mocks.ECSIMService, action, fn _chan, request ->
    decoded = request |> request.__struct__.encode() |> request.__struct__.decode()
    assert decoded == request
    {:ok, actual_response}
  end)
end
```

**Other dependencies** (k8s client, external HTTP): Mox when a behaviour exists, manual stub module when not.
