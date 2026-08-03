# Operational Effects

Forma is a typed, extensible Lisp that compiles operational programs into
portable IR. `Effect<A, E, R>` is the static execution contract of an
operation; it is not the runtime and it is not the whole language.

```text
Effect<Success, ErrorSet<...>, RequirementSet<...>>
```

The three parameters answer what the computation returns, which typed errors
it can produce, and which capabilities a runtime must provide.

## V1 boundary

`E` and `R` are normalized, closed finite sets in v1. `do!` unions those sets,
`catch` removes the error it handles and adds any errors or requirements of its
handler, and duplicate entries are removed. V1 does not provide open rows,
row-polymorphic functions, dynamic handlers, or resumable continuations.

The public forms are:

- `define-error` for schema-backed error payloads
- `define-service` for runtime interfaces
- `define-operation` for operational programs
- `Effect`, `do!`, `succeed`, `fail`, and `catch`

The legacy `define-effect`, `perform`, `handle`, and `->!` forms are not public
Forma syntax. OCaml 5 effects remain an internal implementation technique for
the engine-to-host ABI only.

## Example

```lisp
(define-error EmployeeNotFound
  (:fields (field id String)))

(define-service EmployeeStore
  (:methods
    (find [id String]
      (Effect Employee [EmployeeNotFound] []))))

(: load-employee
  (-> String
      (Effect Employee [EmployeeNotFound] [EmployeeStore.find])))
(define-operation load-employee [id]
  (EmployeeStore.find id))

(: load-or-default
  (-> String Employee
      (Effect Employee [] [EmployeeStore.find])))
(define-operation load-or-default [id fallback]
  (catch
    (load-employee id)
    (EmployeeNotFound error)
    (succeed fallback)))
```

Every service method contributes its operation-granular capability to `R`.
Here the capability is `EmployeeStore.find`, not the coarser
`EmployeeStore`. This same identifier is emitted into authority manifests and
checked by runtimes.

## Errors are values

`fail` accepts a constructed error value, not a type name or an unstructured
string:

```lisp
(fail (EmployeeNotFound {:id id}))
```

The payload is checked against the error schema. Portable IR represents this
as an `Error` value inside a `Fail` node. Runtime adapters may use host
exceptions internally, but the language boundary preserves the error type and
payload.

Typed recovery names the error and binds its payload:

```lisp
(catch operation
  (EmployeeNotFound error)
  (succeed fallback))
```

The caught error must occur in the input computation's `E` set. Catching an
impossible error is a type error. The output error set is the input set without
the caught error, unioned with the handler's errors.

## Portable semantics

The normative pipeline is:

```text
Forma source
  -> HM checking with Effect<A,E,R>
  -> portable typed logic/mechanics IR
  -> runtime adapter
```

The IR contains explicit service/operation calls, constructed error values,
failure, sequencing, and catch. An Effect-TS interpreter can execute that IR,
as can a durable workflow engine, simulator, agent-tool host, native runtime,
or Wasm host. Effect-TS fibers, scopes, interruption, and resource semantics
are backend choices rather than Forma language semantics.

Source/type/IR golden fixtures shared by the TypeScript and OCaml engines are
the compatibility boundary. A backend conforms by implementing the portable
IR, not by reproducing another backend's internal execution library.
