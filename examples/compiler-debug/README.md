---
id: compiler-debug
version: 0.1.0
preludes:
  - core
---

# Compiler Debug

Small compiler fixture focused on demo and debug tooling. It intentionally
covers one entity graph, records, a basic query, a filtered query, an action,
and a query-backed view without pulling in the larger staffing surface.

```lisp
(export-from "./schema.md" [Department Employee])
(import "./records.md" :as records)
(export-from "./query-basic.md" [employee-directory])
(export-from "./query-filtered.md" [active-employees])
(export-from "./action-basic.md" [mark-active])
(export-from "./view-query-binding.md" [employee-directory-view])
```
