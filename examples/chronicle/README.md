---
id: chronicle
version: 0.1.0
preludes:
  - core
---

# Chronicle

Narrative event log example in canonical ontology syntax.

```lisp
(define-entity Chronicle
  (:field [chronicle/title String {:required true}])
  (:field [chronicle/theme String]))

(define-entity Entry
  (:field [entry/title String {:required true}])
  (:field [entry/era String])
  (:field [entry/chronicle (Ref Chronicle)]))
```

```lisp
(define-record "chronicle:founding" Chronicle
  (:field [chronicle/title "Founding Era"])
  (:field [chronicle/theme "origins"]))

(define-record "entry:arrival" Entry
  (:field [entry/title "Arrival of the Archive Fleet"])
  (:field [entry/era "year-zero"])
  (:field [entry/chronicle "chronicle:founding"]))
```

```lisp
(define-query chronicle-entries
  (:from Entry)
  (:select [entry/title entry/era entry/chronicle]))
```
