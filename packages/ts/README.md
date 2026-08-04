# `@forma/ts`

The TypeScript implementation of Forma. It provides the lossless reader,
formatter, macro expander, evaluator, bytecode VM, Hindley–Milner inference,
editor analysis, elaboration protocols, and artifact generation.

```ts
import { Evaluator, Reader, Type } from "@forma/ts";
import { parseManyToSExpr } from "@forma/ts/reader";
import { inferSourceStr } from "@forma/ts/type";
```

The package is runtime-neutral. Domain forms and target-specific behavior are
registered by consumers through descriptors, preludes, and host services.

```sh
pnpm --filter @forma/ts build
pnpm --filter @forma/ts test
pnpm --filter @forma/ts typecheck
```
