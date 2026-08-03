---
id: family
version: 0.1.0
preludes:
  - core
---

# Family

Family relationships example in canonical ontology syntax.

```lisp
(define-entity Household
  (:field [household/name String {:required true}]))

(define-entity Person
  (:field [person/name String {:required true}])
  (:field [person/role String])
  (:field [person/household (Ref Household)]))
```

```lisp
(define-record "household:rivera" Household
  (:field [household/name "Rivera Household"]))

(define-record "person:maya" Person
  (:field [person/name "Maya Rivera"])
  (:field [person/role "parent"])
  (:field [person/household "household:rivera"]))
```

```lisp
(define-query household-members
  (:from Person)
  (:select [person/name person/role person/household]))
```
