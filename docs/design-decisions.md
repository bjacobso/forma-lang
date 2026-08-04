# Design decisions

## Two engines remain intentional

The TypeScript engine provides low-friction embedding and browser execution.
The OCaml engine provides a strongly typed implementation, native performance,
and a single source for native, JavaScript, and WebAssembly targets. Shared ABI
and conformance suites prevent the implementations from becoming separate
languages.

## Domain vocabulary belongs in preludes

Adding consumer nouns as compiler built-ins would close the extension point and
couple the project to one use case. Forma instead exposes descriptors and meta
hooks, with source-level preludes defining domain forms.

## Effects lower to portable data

The language tracks failures and requirements statically, but target backends
do not need native algebraic-effect support. Explicit IR operations allow a
host to use promises, an effect library, a state machine, or native handlers.

## Artifacts cross a typed boundary

Artifact envelopes, declarations, summaries, and validation are typed before
serialization. JSON construction happens at named ABI boundaries, and the
media type is `application/vnd.forma.ir+json`.

## Compatibility follows publication

The project is pre-alpha and its packages are unpublished. Internal names and
wire contracts can change together while conformance remains green. Once a
public release exists, compatibility and migration policy become explicit
release requirements.
