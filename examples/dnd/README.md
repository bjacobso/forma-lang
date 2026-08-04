---
id: dnd
version: 0.1.0
preludes:
  - core
---

# D&D

Tabletop campaign example in canonical ontology syntax.

```lisp
(define-entity Campaign
  (:field [campaign/name String {:required true}])
  (:field [campaign/tier String]))

(define-entity Character
  (:field [character/name String {:required true}])
  (:field [character/class String])
  (:field [character/campaign (Ref Campaign)]))
```

```lisp
(define-record "campaign:shattered-sea" Campaign
  (:field [campaign/name "Shattered Sea"])
  (:field [campaign/tier "mid"]))

(define-record "character:orin" Character
  (:field [character/name "Orin Vale"])
  (:field [character/class "bard"])
  (:field [character/campaign "campaign:shattered-sea"]))
```

```lisp
(define-query party
  (:from Character)
  (:select [character/name character/class character/campaign]))
```
