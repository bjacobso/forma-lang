---
id: insurance
version: 0.1.0
preludes:
  - core
---

# Insurance

Insurance policy and claims example in canonical ontology syntax.

```lisp
(define-entity PolicyHolder
  (:field [policy-holder/name String {:required true}])
  (:field [policy-holder/segment String]))

(define-entity Claim
  (:field [claim/status String {:required true}])
  (:field [claim/amount Number])
  (:field [claim/policy-holder (Ref PolicyHolder)]))
```

```lisp
(define-record "policy-holder:acme" PolicyHolder
  (:field [policy-holder/name "Acme Manufacturing"])
  (:field [policy-holder/segment "commercial"]))

(define-record "claim:wind" Claim
  (:field [claim/status "open"])
  (:field [claim/amount 42000])
  (:field [claim/policy-holder "policy-holder:acme"]))
```

```lisp
(define-query open-claims
  (:from Claim)
  (:where (= (get it :claim/status) "open"))
  (:select [claim/status claim/amount claim/policy-holder]))
```
