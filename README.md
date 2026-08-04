# Forma

Forma is a typed, homoiconic Lisp for building domain-specific languages.
Programs remain compact and reviewable while the compiler exposes every stage:
reading, macro expansion, type inference, evaluation, elaboration, and artifact
emission.

Forma is a pre-alpha research project. The implementation is real and tested,
but its APIs and wire formats are still evolving.

## Why Forma

- **Typed macros** extend syntax without giving up useful source diagnostics.
- **Elaborator reflection** lets hosts register new forms and typed IR nodes
  without adding domain vocabulary to the language core.
- **Operational effects** make failures and required capabilities visible in
  portable IR.
- **Inspectable compilation** treats intermediate artifacts as a product
  surface rather than a hidden implementation detail.
- **Two engines** provide a fast TypeScript implementation and an OCaml engine
  that targets native code, JavaScript, and WebAssembly.

## Quick start

Requires Node.js 24 and pnpm 10.20.

```sh
pnpm install --frozen-lockfile
pnpm test
pnpm dev
```

The website and live compiler demos run at the Vite URL printed by `pnpm dev`.

The OCaml engine additionally requires OCaml 5.2, Dune, `js_of_ocaml`, and
`wasm_of_ocaml`:

```sh
mise install
mise run forma:ocaml:test
```

## Runtime configuration

- `FORMA_OCAML_CLI` overrides the native `forma_cli` artifact.
- `FORMA_OCAML_JS` overrides the JavaScript OCaml artifact.
- `FORMA_LANGUAGE_SERVER_ARTIFACT` overrides the language-server engine artifact.
- `FORMA_LANGUAGE_SERVER_PRELUDES` supplies comma-separated, consumer-owned prelude paths.
- `FORMA_LANGUAGE_SERVER_ENABLE_FORMATTING` enables language-server formatting.
- `FORMA_DISABLE_NATIVE_ELABORATION` selects the portable elaboration path.
- `FORMA_DAEMON_TIMEOUT_MS` controls native daemon request timeouts.

## Workspace

| Project | Purpose |
| --- | --- |
| `@forma/ts` | TypeScript reader, evaluator, VM, typechecker, and elaborator |
| `@forma/ocaml` | Native/JavaScript/WebAssembly compiler and interpreter engine |
| `@forma/host` | Shared host ABI across engine implementations |
| `@forma/editor` | CodeMirror and React editing components |
| `@forma/language-server` | Language Server Protocol implementation |
| `@forma/website` | Browser-based compiler explorer and project site |
| `conformance/` | Cross-engine semantic and effect fixtures |

Start with the [vision](docs/vision.md), then read the
[architecture](docs/architecture.md) and [language guide](docs/language.md).

## Status

Package names reserve the intended `@forma` surface, but nothing in this
repository is published automatically. The website configuration supports a
deployment dry run; CI never deploys it.

## License

[MIT](LICENSE)
