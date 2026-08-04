# `@forma/website`

The static Vite/React site and browser compiler explorer for `forma-lang.com`.
Its live pipelines run `@forma/ts` in a Web Worker and expose source, syntax,
inferred types, evaluated values, and generated artifacts.

```sh
pnpm --filter @forma/website dev
pnpm --filter @forma/website test
pnpm --filter @forma/website build
pnpm --filter @forma/website test:visual
pnpm website:dry-run
```

The checked-in Cloudflare configuration supports static assets and route-aware
metadata. CI validates it with a dry run and does not contain a deployment job.
