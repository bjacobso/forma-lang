# Architecture

Forma separates language machinery from consumer-defined vocabulary.

```text
source
  → lossless read / parse
  → macro expansion
  → core lowering
  → type inference
  → evaluation or elaboration
  → typed artifact packaging
  → JSON ABI / target backend
```

## Engines

`@forma/ts` is the embeddable TypeScript engine used by the browser demo and
the default host. `@forma/ocaml` is the typed engine and compiler substrate,
building to native code, JavaScript, and WebAssembly. Cross-engine fixtures
define the portable semantic intersection.

Neither engine owns consumer concepts such as entities, endpoints, workflows,
or UI components. Those arrive as ordinary preludes plus descriptor and meta
hook registrations.

## Host boundary

`@forma/host` presents one asynchronous ABI for parsing, inference, evaluation,
sessions, editor analysis, retained values, and host calls. Implementations
adapt the TypeScript engine, the native OCaml daemon, or the JavaScript OCaml
artifact to that contract.

The native daemon uses newline-delimited JSON. Long-lived sessions retain
loaded sources, generalized definitions, artifact caches, and suspended host
calls. One-shot requests remain available for simple compiler invocations.

## Tooling

`@forma/editor` provides syntax, structural editing, diagnostics, hover, and
React bindings. `@forma/language-server` projects the OCaml editor ABI into
standard Language Server Protocol requests. It starts domain-neutral and loads
only preludes explicitly supplied by its consumer.

The website executes the TypeScript compiler in a Web Worker. Every displayed
stage is computed from the editable source in the tab; preview-only target
artifacts are visibly distinguished from live compiler output.
